%publisher
pub_enable=rospublisher('/cmd_motor_state','std_msgs/Int32');
%declaraci�n mensaje
msg_enable_motor=rosmessage(pub_enable);
%activar motores enviando enable_motor = 1
msg_enable_motor.Data=0;
send(pub_enable,msg_enable_motor);