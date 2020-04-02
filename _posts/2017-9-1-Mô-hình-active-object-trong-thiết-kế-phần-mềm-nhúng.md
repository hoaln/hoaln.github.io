---
layout: post
title: Mô hình active object trong thiết kế phần mềm nhúng
---

*Bài này được viết từ năm 2017 khi đang phát triển platform cho các hệ máy thông tin quân sự tại Viettel. Từ đó đến nay, thư viện phần mềm dựa trên các khái niệm về active object này đã được ứng dụng ở các sản phẩm máy thông tin vô tuyến trong quân sự, HMI, Control-Box, BMS, Telematics-Box cho xe điện 2 bánh, dùng để implement hiệu quả các giao thức để tìm kênh truyền tốt nhất trên sóng HF, giao thức backbone trong xe điện trên nền CAN để download firmware, diagnostic, authentication; nền tảng hardware sử dụng cũng đa dạng từ Cortex M0 đến M7, chạy baremetal trên chip low-end 8K ram đến chạy đa luồng trên nền RTOS trên những dòng mcu tài nguyên dồi dào hơn.*

# **MÔ HÌNH ACTIVE OBJECT TRONG THIẾT KẾ PHẦN MỀM NHÚNG**

TÓM TẮT

_**Khái niệm Actor lần đầu tiên được sử dụng vào những năm 1970 do Carl Hewitt đưa ra để chỉ các đối tượng phần mềm độc lập giao tiếp với nhau thông qua truyền bản tin. Chuẩn UML sau đó giới thiệu khái niệm khái niệm active object là đối tượng có tác vụ điều khiển của riêng nó (&quot; an object having its own thread of control&quot; ) để xử lí các sự kiện cho đến khi hoàn thành (run to completion) trao đổi bởi các active object khác. Chuẩn UML cũng mở rộng active object là một đối tượng có trạng thái, tùy vào lịch sử hiện tại active object đó mà nó xử lí cùng sự kiện đến khác nhau. Có nhiều công cụ thiết kế tự động cho hệ thống nhúng hỗ trợ chuyển thiết kế theo mô hình active object với UML sang mã nguồn như ROOM virtual machine, VisualSTATE engine của IAR, Object Excution Framework của Rhapsody I-logix, Stateflow của MathWorks… Thay vì dùng các công cụ trên báo cáo này trình bày các thành phần cơ bản để tự xây dựng một hệ thống theo mô hình Active Object đáp ứng các tiêu chí về gọn nhẹ (tùy vào nền tảng phần cứng), tin cậy, tiền định và đáp ứng thời gian thực**_

**TỪ KHÓA:** _Active Object; Phần mềm hệ thống; State Machine; Event Driven Architect_

1. **GIỚI THIỆU CHUNG**

Một chương trình phần mềm nhúng có thể được thực thi bằng nhiều cách. Cách đơn giản nhất là bao gồm 1 chương trình main có vòng lặp vô tận chờ xử lí sự kiện với các sự kiện được kích hoạt từ chương trình phục vụ ngắt.

```cpp
void main() {

    while(1) { //endless loop
        switch(event) { 
            case 0: //event 0
             //do something
            break;
        }
      Delay(20); //wait 20ms for new event
    }
}
void ISR0() {
   event = 0;
}
```  
Hình 1:

Cách tiếp cận theo lập trình tuần tự này sẽ không đáp ứng được việc xử lí sự kiện tức thì khi mà hệ thống lớn dần và cần xử lí nhiều sự kiện hơn

Giải pháp khi hệ thống trở nên lớn hơn một cách tự nhiên là sử dụng một hệ điều hành thời gian thực (RTOS). Thay vì chỉ có một vòng lặp vô tận thì ta có nhiều vòng lặp vô tận chạy trên từng tác vụ khác nhau với cấu trúc giống như Hình 1. Tuy nhiên nếu hệ thống chỉ đơn thuần là nhiều tác vụ hơn thì chương trình vẫn không đảm bảo đáp ứng thời gian thực tốt hơn do các tác vụ vẫn luân phiên chiếm quyền điều khiển CPU chỉ đề polling các sự kiện. RTOS giải quyết vấn đề này bằng cách hỗ trợ cơ chế thread blocking thông qua semaphore, mailbox … khi đó tác vụ chỉ chiếm quyền CPU khi thực sự có sự kiện diễn ra. Một chương trình sử dụng RTOS điển hình lúc đó sẽ giống như Hình 2

```cpp
 void *thread_handler(void *arg) {   
  /* super loop */
   SEvt e;
   while(1) {
     Mbx_Pend(mbx, &e,SYS_FOREVER);

     switch(e.msg_id) {
    	  case msg0:
                  ProcMsg0();
	   break;  
//	…
     }
   }
    return (void *)0; /* return success */
}
```  
Hình 2:

Tuy nhiên mô hình trên chưa giải quyết hết những vấn đề ta sẽ gặp phải khi một hệ thống lớn dần lên. Hầu hết các hệ thống nhúng sẽ đồng thời là hệ thống đa trạng thái khi đó tùy vào trạng thái hiện tại mà sự kiện gửi đến sẽ được xử lí khác nhau. Phần đa các các trạng thái được lưu thành các biến cờ hệ thống, khi đó mỗi hàm xử lí ứng với một sự kiện sẽ trông giống như Hình 3

```cpp
if(X_state == state_x_0) {
   //do sth 
} else {				
  if(Y_state == state_y_0) {	
      //do sth				
  } else {
    if(Z_state == state_z_0 && Q_state != state_q_1) {	//do sth				
    } else if() {
       //do sth
    }
  }
} //spaghetti code: multi nested loop!
```  
Hình 3:

Một khi hệ thống lớn dần, số sự kiện, số trạng thái nhiều hơn, chương trình sẽ không thể bảo trì được. Thêm vào đó, nếu các biến trạng thái được chia sẻ giữa nhiều luồng sẽ tăng xác suất  xung đột giữa các luồng, deadlock, priority inversion … đe dọa sự ổn định hệ thống. Tùy vào kinh nghiệm của nhà phát triển để lựa chọn hệ thống nên có bao nhiêu luồng, bao nhiêu cờ trạng thái, cờ trạng thái nào được quản lí bởi luồng nào… sẽ quyết định khả năng mở rộng của hệ thống. Những câu hỏi này sẽ được trả lời trong mô hình thiết kế theo active object.

2. **MÔ HÌNH ACTIVE OBJECT**

  2.1  ***CÁC ĐẶC TRƯNG MÔ HÌNH ACTIVE OBJECT***

Khái niệm active object được mô tả bởi các đặc trưng:

* --Mỗi active object bao gồm một luồng nơi nó dùng phần lớn thời gian để đợi và sau đó để xử lí sự kiện được gửi đến.
* --Dữ liệu thuộc về active object chỉ được sử dụng trong luồng kiểm soát bởi active object đó.
* --Các active object không chia sẻ dữ liệu của mình mà trao đổi thông tin qua cơ chế truyền sự kiện.
* --Mỗi active object bao gồm hệ thống xử lí trạng thái phân cấp (hierarchical state machine - HSM)

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/act-hinh-4.jpg)  
Hình 4:

Chương trình sẽ được thiết kế phân chia thành các active object chịu trách nhiệm cho các tài nguyên khác nhau của hệ thống: điều khiển ngoại vi, giao tiếp với mạch ngoài … Hệ thống có bao nhiêu &quot; tài nguyên&quot; thì sẽ có bấy nhiêu luồng và HSM đi kèm (acive object).

   2.2  ***CƠ CHẾ TRUYỀN THÔNG ĐIỆP***

Cơ chế truyền thông điệp là nền tảng cơ bản của hệ thống xử lí theo sự kiện. Cơ chế truyền thông giữa các active object được xây dựng trên cơ sở các tính năng semaphore, mailbox … của RTOS.

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/act-hinh-5.jpg)  
Hình 5:

RTOS thông thường sẽ hỗ trợ cơ chế mailbox trong đó dữ liệu từ lúc ghi vào và đọc ra sẽ mất hai lần sao chép (thực hiện bở RTOS). Khi thông điệp có độ dài lớn thì cơ chế trên sẽ làm tăng độ trễ truyền thông giữa các active object.

Mô hình active object sử dụng cơ chế &quot; zero-copy&quot; như Hình 6
 
![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/act-hinh-6.jpg)  
Hình 6:

Trong cơ chế &quot; zero-copy&quot; , một event sẽ được cấp phát động trong event pool, và RTOS sẽ chỉ truyền con trỏ trỏ đến event đã được cấp phát. Sau khi event được xử lí, nó sẽ được giải phóng khỏi event pool.Để đảm bảo tính tiền định của chương trình.cũng như chống phân mảnh bộ nhớ, việc cấp phát động event sẽ được thực hiện thông qua **fixed-size buffer pattern** (không cấp phát từ heap).

Để hỗ trợ một event có thể được dùng để truyền đến nhiều đối tượng (gửi multicast), mô hình active object sử dụng **reference counting pattern** để kiểm soát việc một event đã được xử lí hết ở tất cả các đối tượng mà nó được gửi đến hay chưa. Sau khi kiểm tra event đã được xử lí hết, hệ thống mới thu hồi event này khỏi event pool.

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/act-hinh-7.jpg)  
Hình 7:

Mô hình active object cũng hỗ trợ xử lí các sự kiện chờ. Khi một sự kiện được gửi đến mà hệ thống chưa kịp về đúng trạng thái cần thiết, sự kiện đó có thể được đưa vào hàng đợi và sẽ được gọi lại để xử lí khi hệ thống chuyển về trạng thái đúng.

![](https://raw.githubusercontent.com/hoaln/hoaln.github.io/master/active_object_images/act-hinh-8.jpg)  
Hình 8:

  2.3  ***XỬ LÝ TRẠNG THÁI***

Để tăng tính kế thừa, mô hình active object sử dụng sơ đồ trạng thái phân cấp, các sơ đồ trạng thái con có thể kế thừa hàm xử lí sự kiện từ sơ đồ trạng thái cha.

```cpp
#define HSM_DEFINE_STATE(TYPE, STATE, PARENT) \
  static State STATE(TYPE * const me, SEvt const * const e); \
  static HsmState STATE##_s = {.parent = (HsmState*)PARENT, .func = (StateHandler*) &STATE}

//Two state Rx and Tx
HSM_DEFINE_STATE (SModuleAO, ModuleX_tx, &ModuleX_sup_s);
HSM_DEFINE_STATE (SModuleAO, ModuleX_rx, NULL);

static State ModuleX_tx(SModuleAO * const me,  SEvt const * const e) {
  State ret = RET_HANDLED;

  switch(e->u8Sig) {

     case ENTRY_SIG:
      ret = RET_ENTRY;
     break;

     case EXIT_SIG:
      ret = RET_EXIT;
     break;

     case CHANGE_RX_SIG:
	ret = TRANS_STATE(&ModuleX_rx_s);
     break;

     default:
	ret = TRANS_SUPER(&ModuleX_sup_s);
     break;
   }

   return ret;
}
```  
Hình 9:

Hình 9 mô tả ví dụ một active object có 2 trạng thái **ModuleX\_tx**, **ModuleX\_rx**, trạng thái TX có 1 lớp cha là Trạng thái **ModuleX\_sup**. Các sự kiện **ENTRY** và **EXIT** sẽ được gọi bởi hệ thống khi xảy ra việc thay đổi trạng thái. Có thể thấy hàm xử lí trạng thái của **ModuleX\_tx** chỉ xử lí sự kiện **CHANGE\_RX**, các sự kiện khác được kế thừa xử lí từ lớp cha là **ModuleX\_sup**. Việc định nghĩa các trạng thái như là các con trỏ hàm thay biến cũng hạn chế việc trạng thái bị thay đổi  ngoài ý muốn bởi tầng ứng dụng, mọi tác động lên con trỏ hàm này được ẩn trong tầng hệ thống.

```cpp
void Hsm_Dispatch(Hsm * const me, SEvt const * const e) { 
 HsmState const *s;
 HsmState const *t;
 State ret;

/* save the current state */
 t = me->current_state;            		
/* process the event hierarchically... */
 do {                             		
	 s = me->target_state;

	 if(s!= NULL && IS_FNC_PTR_VALID(s->func)) {
	   /* invoke state handler s */
		ret = ((StateHandler)(s->func))(me, e);     	
	   } else {
	   /*  terminate state handler */
	   ret = RET_IGNORED;	 		
	   }
   } while (ret == RET_SUPER);

 if (ret == RET_TRAN) {
    t = me->target_state;	/* save the target state */
	/* exit states from the current state to the tran. source state, not call s->exit */
	Hsm_Exit2Parrent(me, me->current_state, s);

	/* execute transition action */
	if(me->trans_tabl != NULL) {			
	/* multiple action when transition */
	 STranAct* a;
	 for (a = &me->trans_tabl[0]; (a->state) != 0; ++a) {
		/* call the action through the 'a' pointer */     
		((StateHandler)(a->state))(me, a->evt);       
	 }
	} else {
	   HsmState const * lca = NULL;
		  if (Hsm_is_ancestor(s, t)) {
		   lca = s;
		  } else {
		  if (Hsm_is_ancestor(t, s)) {
		   lca = t;
		  } else {
		   lca = SDRHsm_find_lca(s, t);
		  }
	 }

	/* exit from trans. source state to lca, not call lca->exit */
	Hsm_Exit2Parrent(me, s, lca);

	HsmState const * from;
	  if(lca == NULL) {
		 from = t;
	  } else {
		 /* trace back to lca */
		 from = t;
		 while(from->parent != lca) {
		   from = from->parent;
		 }
	}

	/* enter from lca -> final */
	 Hsm_Enter2Child(me, from);
	 t = me->target_state;			
	/* update final target state */
	}
  }
}
```  
Hình 10:

Hình 10 mô tả cách thức hệ thống xử lí các sự kiện gửi tới. Có thể thấy nếu kết quả trả về của hàm xử lí trạng thái là **RET\_SUPER** thì hàm xử lí lớp trên với cùng sự kiện đó sẽ được gọi cho đến khi sự kiện đó được xử lí.

Khi hàm xử lí chuyển từ trạng thái **ModuleX\_tx** sang **ModuleX\_rx**, hệ thống sẽ gọi lần lượt đến hàm xử lí các sự kiện EXIT của **ModuleX\_tx**, **EXIT** của **ModuleX\_sup** (lớp cha), và **ENTRY** của **ModuleX\_rx**.  
Quá trình chuyển trạng thái sử dụng giải thuật lowest common ancestor để tìm lớp thấp nhất mà cả hai trạng thái này đều kế thừa và sau đó gọi các hàm xử lí **EXIT**, **ENTRY** tương ứng trong chuỗi thay đổi trạng thái.

3. **KẾT LUẬN**

Mô hình Active Object cung cấp một hướng dẫn về việc lập trình hệ thống nhúng xử lí các sự kiện, giúp việc chuyển đổi từ mô hình thiết kế UML sang mã nguồn gần như là trực tiếp. Chúng tôi sử dụng mô hình này trong thiết kế hệ thống, triển khai giao thức ALE3G, giao thức DSC … Tùy vào mức độ phức tạp của hệ thống trạng thái mà chúng tôi quyết định sử dụng một dạng đơn giản hơn HSM là finite state machine (FSM), hoặc thậm chí là có những đối tượng không có sơ đồ trạng thái. Tuy nhiên các tư tưởng thiết kế của mô hình active object được chúng tôi tuân theo như là công thức chung khi phát triển một hệ thống nhúng theo kiến trúc xử lí sự kiện.

**TÀI LIỆU THAM KHẢO**

1. Miro Samek, (2009) _Practical UML Statecharts in C/C++._ Books. Newnes Publications. ISBN 978-0-7506-8706-5.

2. Stefan Heinzmann, (2004). _Yet Another Hierachical State Machine_. Overload, Issue 64, December 2004, 14-21.

