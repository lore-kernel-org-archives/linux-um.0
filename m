Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DURKB-0007AC-4l	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:34:39 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DURK8-0006De-QH	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:34:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<20050504132701.GA3755@ccure.user-mode-linux.org>
	<427A51F9.2060208@manchester.ac.uk>
In-Reply-To: <427A51F9.2060208@manchester.ac.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f6NfCITj76H00xA"
Message-Id: <200505071728.31647.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 7 May 2005 17:28:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ian Rogers <ian.rogers@manchester.ac.uk>

--Boundary-00=_f6NfCITj76H00xA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 05 May 2005 19:03, Ian Rogers wrote:
> Hi,
>
> I've attached the test/example I'm working on to create and manipulate
> address spaces uses skas - as I want to allow an emulator to. There are
> a few missing functions (that can be pretty much cloned from mem_user.c)
> and I've not worked out how to calculate the descriptor value yet.

> Please could you have a look and suggest how to create the descriptor
> value and why when I look in /proc/<pid>/maps I can't see the asid_mmap
> that's being done as part of the test.
Because you didn't switch the child to use the new MM. The MMAP you do is not 
related in any way to the child, because you don't pass in the param, right?

Instead, it's related to the mm_fd you open.

In fact, in the code attached (which is a more working example, I didn't go so 
far to making sure that the child actually works) I've used PTRACE_SWITCH_MM 
too. And moved mm_fd to inside AdressSpace, in place of ->descriptor. The 
included "cat /proc/<pid>/maps" shows that it works.

The child should be almost to the point of running well (maybe it already 
does), though I've no way to make sure of that (I'll have it either to a 
syscall to be intercepted from the parent or write a value in the memory, or 
do an inline syscall). I'd also avoid deleting the file to examine it later.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_f6NfCITj76H00xA
Content-Type: text/x-csrc;
  charset="iso-8859-15";
  name="skas_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="skas_test.c"

/* 
 * Program to create a dummy address space and play with it (much as
 * an emulator would) using the skas linux kernel module
 *
 * This code copies and is based upon code:
 * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
 *
 * Copyright (C) 2005 Ian Rogers, The University of Manchester
 * (http://www.cs.manchester.ac.uk/apt/projects/jamaica/)
 *
 * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso,
 * The University of Catania (Italy)
 *
 * Licensed under the GPL
 */
#define _GNU_SOURCE 500

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <linux/unistd.h>
#include <sched.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <asm/page.h>

/**
 * Taken from arch/um/kernel/skas/include/proc_mm.h
 */
struct ptrace_faultinfo {
        int is_write;
        unsigned long addr;
};

struct ptrace_ldt {
        int func;
        void *ptr;
        unsigned long bytecount;
};

#define PTRACE_FAULTINFO 52
//#define PTRACE_SIGPENDING 53
#define PTRACE_LDT 54
#define PTRACE_SWITCH_MM 55

/**
 * Taken from arch/um/kernel/skas/include/proc_mm.h
 */
#define MM_MMAP 54
#define MM_MUNMAP 55
#define MM_MPROTECT 56
#define MM_COPY_SEGMENTS 57

struct mm_mmap {
	unsigned long addr;
	unsigned long len;
	unsigned long prot;
	unsigned long flags;
	unsigned long fd;
	unsigned long offset;
};

struct mm_munmap {
	unsigned long addr;
	unsigned long len;	
};

struct mm_mprotect {
	unsigned long addr;
	unsigned long len;
        unsigned int prot;
};

struct proc_mm_op {
	int op;
	union {
		struct mm_mmap mmap;
		struct mm_munmap munmap;
	        struct mm_mprotect mprotect;
		int copy_segments;
	} u;
};
/**
 * Generate verbose output
 */
#define VERBOSE 1
/**
 * Maximum number of creatable address spaces
 */
#define MAX_ADDRESS_SPACES 1
/**
 * Maximum number of maps within the address space
 */
#define MAX_MAPS 128
/**
 * The size of blocks in the physical memory backing store
 */
#define BACKING_STORE_CHUNK_SIZE PAGE_SIZE
/**
 * The size of blocks in the physical memory backing store
 */
#define ADDRESS_SPACE_SIZE (BACKING_STORE_CHUNK_SIZE * MAX_MAPS)
/**
 * The size of blocks in the physical memory backing store
 */
#define BACKING_STORE_SIZE (ADDRESS_SPACE_SIZE * MAX_ADDRESS_SPACES)
/**
 * Information held about an address space
 */
struct AS_info {
  /**
   * Handle for /proc/mm - there's a handle for this for every context in UML
   */
  int mm_fd;
  /**
	* The file descriptor of the physical memory backing store file.
	* Currently I don't know why you'd want this but I'm replicating
	* Jeff Dike's structures.
	*/
  int fd;
  /**
	* Per memory map information
	*/
  struct _map_info_t {
	 /**
	  * The virtual address this map information corresponds to
	  */
	 void *virtual_address;
	 /**
	  * The offset within the physical memory backing store file
	  */
	 unsigned long long offset;
  } map_info[MAX_MAPS];
  /**
	* The process identifier created for this address space
	*/
  int pid;

  /*XXX: this is not very useful, unless your app uses modify_ldt().*/
  /**
	* An i386 descriptor value that can be used to access the address
	* space
	*/
  int descriptor;
};
/**
 * Information on created address spaces
 */
struct AS_info AddressSpaces[MAX_ADDRESS_SPACES];
/**
 * The next available address space
 */
int nextFreeAddressSpace = 0;
/**
 * Handle for physical memory backing store
 */
int physmem_fd;

/**
 * Initialize
 */
void initialize()
{
  // make physical memory backing store
  // - try to use /dev/anon as it won't leave unmapped pages in memory
	physmem_fd = open("/dev/anon", O_RDWR);
	if (physmem_fd > 0) {
	  // check we can map to a /dev/anon type file
	  void *addr = mmap(NULL, BACKING_STORE_SIZE, PROT_READ | PROT_WRITE , MAP_PRIVATE, physmem_fd, 0);
	  if(addr == MAP_FAILED){
		 perror("Error during mapping physmem file on /dev/anon");
		 exit(1);
	  }
	  munmap(addr, BACKING_STORE_SIZE);
	  if(VERBOSE) fprintf(stderr, "Created backing store file on /dev/anon\n");
	}
	else {
	  // create a regular file for the backing store
	  const char *physmem_filename = "/tmp/address_space_backing_store_XXXXXX";
	  char temp_filename[1024];
	  strcpy(temp_filename, physmem_filename);
	  physmem_fd = mkstemp(temp_filename);
	  if(physmem_fd < 0){
		 perror("Error during creation of a backing store file");
		 exit(1);
	  }
	  if(unlink(temp_filename) < 0) {
		 perror("Error during unlinking of backing store file");
		 exit(1);
	  }
	  if(VERBOSE) fprintf(stderr, "Created backing store file %s\n", temp_filename);
	}
	// Set close on exit
	int err = fcntl(physmem_fd, F_SETFD, FD_CLOEXEC);
	if(err < 0) {
	  perror("Error during setting close on exit");
	  exit(1);
	}
}

/*Don't use the glibc version, which caches the result in TLS. It misses some
 *  * syscalls, and also breaks with clone(), which does not unshare the TLS.*/
inline _syscall0(pid_t, getpid)

/**
 * Create an address space or die
 * @return the address space identifier (ASID) for this address space
 */
static int address_space_tramp(void *arg)
{
	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill(getpid(), SIGSTOP);
	//Just to avoid this warning!
	return (long) arg;
}
int create_address_space()
{
  // the address space we're working on
  int ASID = nextFreeAddressSpace;
  // pointers to a stack and a fake stack pointer
  void *stack, *sp;
  // temporaries
  int i, n, status, mm_fd;
  // get a handle to /proc/mm
  mm_fd = open("/proc/mm", O_WRONLY);
  if(mm_fd == -1){
	 perror("Failed to open /proc/mm");
	 exit(1);
  }
  if(VERBOSE) fprintf(stderr, "Opened /proc/mm\n");
  AddressSpaces[ASID].mm_fd = mm_fd;
  // setup file descriptor
  AddressSpaces[ASID].fd = physmem_fd;
  // nullify maps and set offsets within backing store file
  for(i=0; i<MAX_MAPS; i++) {
	 AddressSpaces[ASID].map_info[i].virtual_address = ((void*)-1); 
	 AddressSpaces[ASID].map_info[i].offset = (ASID * ADDRESS_SPACE_SIZE) + (i * BACKING_STORE_CHUNK_SIZE);
  }
  // Create address space using clone
  stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if(stack == MAP_FAILED) {
	 perror("Failed to create dummy user space stack");
	 exit(1);
  }
  sp = (void*)(((unsigned long) stack) + PAGE_SIZE - sizeof(void *));
  AddressSpaces[ASID].pid = clone(address_space_tramp, (void *) sp, 
		    CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
  if(AddressSpaces[ASID].pid < 0) {
	 perror("Failed to create address space: clone failed");
	 exit(1);
  }
  do {
	 do {
		n = waitpid(AddressSpaces[ASID].pid, &status, WUNTRACED);
	 } while ((n < 0) && errno == EINTR);
	 if(n < 0) {
		perror("Failed to create address space: wait failed");
		exit(1);
	 }
  } while(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));
  
  if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)){
	 fprintf(stderr,"Failed to create address space: expected SIGSTOP, got status = %d",status);
	 exit(1);
  }
  /*if(munmap(stack, PAGE_SIZE) < 0) {
	 perror("Failed to create address space: munmap failed");
	 exit(1);
  }*/
  //XXX: this is useless
  // set up descriptor - TODO!!!
  AddressSpaces[ASID].descriptor = -1;
  // move along and return
  nextFreeAddressSpace++;
  if(VERBOSE) fprintf(stderr, "Created address space %d\n", ASID);
  return ASID;
}
/**
 * Perform an mmap in the specified ASID or die
 * @param ASID the address space identifier
 * @param virt the address in the ASID to allocate
 * @param len the size of memory to allocate
 * @param r read permission
 * @param w write permission
 * @param x execute permission
 */
void asid_mmap(int ASID, void *virt, unsigned long len, int r, int w, int x)
{
  // Data structure to write to the skas linux kernel module
  struct proc_mm_op operation;
  // The protection mask
  int prot;
  // The map within the address space we're going to use
  int map = -1;
  // temporary
  int i;
  // Check this will fit into the physical memory backing store
  if(len > BACKING_STORE_CHUNK_SIZE) {
	 // Number of map structures required for this mapping
	 int num_maps = (len + BACKING_STORE_CHUNK_SIZE - 1) / BACKING_STORE_CHUNK_SIZE;
	 for(i=0; i < num_maps; i++) {
		asid_mmap(ASID, virt + (i * BACKING_STORE_CHUNK_SIZE), BACKING_STORE_CHUNK_SIZE, r, w ,x);
	 }
  } else {
	 // Find a map to use
	 for (i=0; i < MAX_MAPS; i++) {
		if(AddressSpaces[ASID].map_info[i].virtual_address == virt) {
		  map = i;
		  break;
		}
	 }
	 if (map == -1) {
		for (i=0; i < MAX_MAPS; i++) {
		  if(AddressSpaces[ASID].map_info[i].virtual_address == ((void*)-1)) {
			 map = i;
			 break;
		  }
		}
		if (map == -1) {
		  fprintf(stderr, "Failed to find a free map to use in address space %d\n", ASID);
		  exit(1);
		}
	 }
	 // Calculate the protection properly
	 prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | (x ? PROT_EXEC : 0);
	 // Generate map to be written
	 operation = ((struct proc_mm_op) { .op 	= MM_MMAP,
		    .u 	= 
		    { .mmap	= 
		      { .addr 		= (unsigned long)virt,
			.len		   = len,
			.prot		= prot,
			.flags		= MAP_SHARED | MAP_FIXED,
			// physical memory backing store
			.fd	      = AddressSpaces[ASID].fd,
			// offset within the backing store
			.offset	= AddressSpaces[ASID].map_info[map].offset
		      } } } );
	 int n = write(AddressSpaces[ASID].mm_fd, &operation, sizeof(operation));
	 if(n != sizeof(operation)) {
		perror("asid_mmap failed");
		exit(1);
	 }
	 if(VERBOSE) fprintf(stderr, "Created page at %p in address space %d\n", virt, ASID);
  }
}

/* These are produced by UML arch/um/kernel/skas/util/mk_ptregs into
 * arch/um/include/skas_ptregs.h from /usr/include/asm/user.h */
#define HOST_FRAME_SIZE 17
#define HOST_FP_SIZE 27
#define HOST_XFP_SIZE 128
#define HOST_IP 12
#define HOST_SP 15
#define HOST_EFLAGS 14
#define HOST_EAX 6
#define HOST_EBX 0
#define HOST_ECX 1
#define HOST_EDX 2
#define HOST_ESI 3
#define HOST_EDI 4
#define HOST_EBP 5
#define HOST_CS 13
#define HOST_SS 16
#define HOST_DS 7
#define HOST_FS 9
#define HOST_ES 8
#define HOST_GS 10

#if 0
/**
 * Perform an munmap in the specified ASID or die
 * @param ASID the address space identifier
 * @param addr the address to deallocate
 * @param len the size of memory to deallocate
 */
void asid_munmap(int ASID, unsigned addr, unsigned long len)
{
  // TODO!!!
}

/**
 * Perform an mprotect in the specified ASID or die
 * @param ASID the address space identifier
 * @param addr the address to modify the permissions
 * @param len the size of memory to modify
 * @param r read permission
 * @param w write permission
 * @param x execute permission
 */
void asid_mprotect(int ASID, unsigned addr, unsigned long len, int r, int w, int x)
{
  // TODO!!!
}
#endif
/**
 * Peek a value in an address space
 * @param ASID the address space to peek
 * @param virt the virtual address to look at
 * @return the value peeked
 */
static inline __attribute__((always_inline)) int asid_peek(void *virt) 
{
  int res;
  asm volatile ("movl (%1), %0\n\t"
					 : "=r" (res)
					 : "r" (virt));
  return res;
}
/**
 * Poke a value into an address space
 * @param ASID the address space to peek
 * @param virt the virtual address to look at
 * @param value the value poked
 */
static inline void asid_poke(void *virt, int value)
{
  asm volatile ("movl %0, (%1)\n\t"
					 :
					 : "r" (value), "r" (virt));
}

static void child_code(void)
{
	int len, i;
	void* virt;
	asm volatile (
			"movl %%eax, (%0)\n\t"
			"movl %%ebx, (%1)\n\t"
			: : "r" (&len), "r" (&virt));

	for (i = 0; i < len; i++) {
		int res;
		if ((res = asid_peek(virt+i)) != i) {
			/* We can't call any routine not in the child address
			 * space. And no, printf isn't; in fact I made asid_peek
			 * inline. */
			//printf("Error at %d, expected %d read %d\n", i, i, res);
		}
	}
}

void address_space_write(int ASID, int* addr, int len)
{
	int i;
	for (i = 0; i < len; i++) {
		if (pwrite(AddressSpaces[ASID].fd, &i, sizeof(int), (long) (addr+i)) != sizeof(int) ) {
			perror("Write on backing file failed:");
			exit(1);
			//printf("Error at %d, expected %d read %d\n", i, i, res);
		}
		//printf("Copied child data onto backing store\n");
	}
	printf("Copied child data onto backing store__END__\n");
}

void code_copy(int ASID, int* addr, int len)
{
	/*void * data = mmap(0, len, PROT_READ|PROT_WRITE, MAP_SHARED, AddressSpaces[ASID].fd, (long) addr);
	memmove(data, child_code, len);
	munmap(data, len);*/
	//int i;
	//for (i = 0; i < len; i++) {
		printf("Copied child code onto backing store __START__\n");
		if (pwrite(AddressSpaces[ASID].fd, child_code, len, (long)addr) != len ) {
			perror("Write on backing file failed:");
			exit(1);
			//printf("Error at %d, expected %d read %d\n", i, i, res);
		}
		printf("Copied child code onto backing store__END__\n");
	//}
}

void asid_activate(int ASID, int len, void* stack, void* data, void* code)
{
  char buf[100];
  sprintf(buf, "ls -l -R --color /proc/%d/ ; cat /proc/%d/maps", AddressSpaces[ASID].pid, AddressSpaces[ASID].pid);
  system(buf);
  if (
      ptrace(PTRACE_SWITCH_MM, AddressSpaces[ASID].pid, 0, AddressSpaces[ASID].mm_fd))
  {
	  perror("Ptrace failed:");
	  exit(1);
  }
  printf("Switched child's MM\n");
  system(buf);
  //sleep(10);
  //printf("Compare %d and %d\n", 8 * 112, HOST_EAX);
  if( ptrace(PTRACE_POKEUSER, AddressSpaces[ASID].pid, HOST_EAX * 4, len) ||
      ptrace(PTRACE_POKEUSER, AddressSpaces[ASID].pid, HOST_EBX * 4, data) ||
      ptrace(PTRACE_POKEUSER, AddressSpaces[ASID].pid, HOST_SP * 4, stack + PAGE_SIZE - sizeof(void*)) ||
      ptrace(PTRACE_POKEUSER, AddressSpaces[ASID].pid, HOST_IP * 4, code) ||
      ptrace(PTRACE_CONT, AddressSpaces[ASID].pid, 0, 0)) {
	  perror("Ptrace failed:");
	  exit(1);
  }
}

/**
 * main
 */
//int main(int argc, char **argv)
int main(void)
{
  initialize();
  int ASID = create_address_space();
  printf("Created %d\n", AddressSpaces[ASID].pid);
  void * stack = (void*) PAGE_SIZE, *code = stack + PAGE_SIZE, *data = code + PAGE_SIZE;
  //Stack
  asid_mmap(ASID, stack, PAGE_SIZE,1,1,0);
  //Code
  asid_mmap(ASID, code, PAGE_SIZE,1,1,1);
  //Data to verify
  asid_mmap(ASID, data, PAGE_SIZE,1,1,0);

  //Write the data to be read.
  address_space_write(ASID, data, PAGE_SIZE);
  code_copy(ASID, code, PAGE_SIZE);
  //sleep(10);
  asid_activate(ASID, PAGE_SIZE, stack, code, data);
  sleep(5);
  return 0;
}
// vim: set sw=2:

--Boundary-00=_f6NfCITj76H00xA--




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
