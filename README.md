# OTRS-ACL-For-Queue-Based-Customer-User
- Built for OTRS CE v6.0  
- ACL module that show ticket queue selection based on selected queue (customer user dynamic field) on customer user profile

1. Create a Dynamic Field

	- Name: PredefineQueue
	- Field type: Dropdown / Multiselect / DB Table (https://opar.perl-services.de/dist/DynamicFieldOTRSDBTable-6.0.6)
	- Object type: Customer User
	
	Key = Queue name 
	Value = Queue name


2. Enable Customer User Dynamic Field mapping at Config.pm

		[ 'DynamicField_PredefinedQueue', undef, 'PredefinedQueue', 1, 0, 'dynamic_field', undef, 0, undef, undef ],
	
	
3. At Customer User profile page, select the desired queue

	[![1.png](https://i.postimg.cc/Y2N7YDqB/1.png)](https://postimg.cc/nMLNtkD3)

	
4. At ticket creation screen, a queue will be show based on the customer profile

	[![2.png](https://i.postimg.cc/Cx5VyFCw/2.png)](https://postimg.cc/KR6WBhsW)
