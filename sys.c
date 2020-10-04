/*
 * sys.c - Syscalls implementation
 */
#include <devices.h>

#include <utils.h>

#include <io.h>

#include <mm.h>

#include <mm_address.h>

#include <sched.h>

#include <errno.h>
#include <system.h>

#define LECTURA 0
#define ESCRIPTURA 1

int check_fd(int fd, int permissions)
{
  if (fd!=1) return -9; /*EBADF*/
  if (permissions!=ESCRIPTURA) return -13; /*EACCES*/
  return 0;
}

int sys_ni_syscall()
{
	return -38; /*ENOSYS*/
}

int sys_getpid()
{
	return current()->PID;
}

int sys_fork()
{
  int PID=-1;

  // creates the child process
  
  return PID;
}

char my_buffer[512];
int sys_write (int fd, char * buffer, int size){
	int result;
	int r;
	//comprovem si fd es correcte o no, sino es correcte fem return	
	int fd_checked = check_fd(fd,ESCRIPTURA);	//checks if fd is correct (fd is correct when check_fd returns 0)
	if(fd_checked != 0) return fd_checked;
	if(buffer == NULL) return -EFAULT;		//bad address
	if(size < 0) return -EINVAL;			//invalid argument

	int blocks = size;
	while(blocks>512){
		copy_from_user(buffer,my_buffer,size);
		r = sys_write_console(my_buffer, 512);
		blocks -= r;
		buffer += r;
	}
	if(blocks>0){
		copy_from_user(buffer,my_buffer,size);
		r = sys_write_console(my_buffer, 512);
		blocks -= r;

	}
	result = (size - blocks);
	return result;
	
}

int gettime(){
	return zeos_ticks;
}


void sys_exit()
{  
}
