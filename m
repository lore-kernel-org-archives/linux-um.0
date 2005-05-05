Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTjk8-0001Ec-SC	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 10:02:32 -0700
Received: from mailhost.cs.man.ac.uk ([130.88.192.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DTjk5-0005m4-SZ	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 10:02:32 -0700
Received: from trinidad ([130.88.195.238])
	by mailhost with esmtp (Exim 4.14)	id 1DTjje-0001KK-Rw
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 18:02:02 +0100
Message-ID: <427A51F9.2060208@manchester.ac.uk>
From: Ian Rogers <ian.rogers@manchester.ac.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<20050504132701.GA3755@ccure.user-mode-linux.org>
In-Reply-To: <20050504132701.GA3755@ccure.user-mode-linux.org>
Content-Type: multipart/mixed;
 boundary="------------030604040803030108020708"
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
Date: Thu, 05 May 2005 18:03:53 +0100
To: User-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030604040803030108020708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've attached the test/example I'm working on to create and manipulate 
address spaces uses skas - as I want to allow an emulator to. There are 
a few missing functions (that can be pretty much cloned from mem_user.c) 
and I've not worked out how to calculate the descriptor value yet. 
Please could you have a look and suggest how to create the descriptor 
value and why when I look in /proc/<pid>/maps I can't see the asid_mmap 
that's being done as part of the test.

Many thanks,

Ian Rogers

--------------030604040803030108020708
Content-Type: text/x-csrc;
 name="skas_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
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
 * Licensed under the GPL
 */
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
#define BACKING_STORE_CHUNK_SIZE 4096
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
 * Handle for /proc/mm - there's a handle for this for every context in UML
 */
int mm_fd;
/**
 * Handle for physical memory backing store
 */
int physmem_fd;

/**
 * Initialize
 */
void initialize()
{
  // get a handle to /proc/mm
  mm_fd = open("/proc/mm", O_WRONLY);
  if(mm_fd == -1){
	 perror("Failed to open /proc/mm");
	 exit(1);
  }
  if(VERBOSE) fprintf(stderr, "Opened /proc/mm\n");
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
/**
 * Create an address space or die
 * @return the address space identifier (ASID) for this address space
 */
static int address_space_tramp(void *arg)
{
	kill(getpid(), SIGSTOP);
	return(0);
}
int create_address_space()
{
  // the address space we're working on
  int ASID = nextFreeAddressSpace;
  // pointers to a stack and a fake stack pointer
  void *stack, *sp;
  // temporaries
  int i, n, status;
  // setup file descriptor
  AddressSpaces[ASID].fd = physmem_fd;
  // nullify maps and set offsets within backing store file
  for(i=0; i<MAX_MAPS; i++) {
	 AddressSpaces[ASID].map_info[i].virtual_address = ((void*)-1); 
	 AddressSpaces[ASID].map_info[i].offset = (ASID * ADDRESS_SPACE_SIZE) + (i * BACKING_STORE_CHUNK_SIZE);
  }
  // Create address space using clone
  stack = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if(stack == MAP_FAILED) {
	 perror("Failed to create dummy user space stack");
	 exit(1);
  }
  sp = (void*)(((unsigned long) stack) + 4096 - sizeof(void *));
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
  if(munmap(stack, 4096) < 0) {
	 perror("Failed to create address space: munmap failed");
	 exit(1);
  }
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
  }
  else {
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
	 int n = write(mm_fd, &operation, sizeof(operation));
	 if(n != sizeof(operation)) {
		perror("asid_mmap failed");
		exit(1);
	 }
	 if(VERBOSE) fprintf(stderr, "Created page at %p in address space %d\n", virt, ASID);
  }
}
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
/**
 * Peek a value in an address space
 * @param ASID the address space to peek
 * @param virt the virtual address to look at
 * @return the value peeked
 */
int asid_peek(int ASID, void *virt)
{
  int res;
  asm volatile ("pushw %w2\n\t"
					 "popw %%fs\n\t"
					 "movl %%fs:(%1), %0\n\t"
					 : "=r" (res)
					 : "r" (virt), "r" (AddressSpaces[ASID].descriptor));
  return res;
}
/**
 * Poke a value into an address space
 * @param ASID the address space to peek
 * @param virt the virtual address to look at
 * @param value the value poked
 */
void asid_poke(int ASID, void *virt, int value)
{
  asm volatile ("pushw %w2\n\t"
					 "popw %%fs\n\t"
					 "movl %0, %%fs:(%1)\n\t"
					 :
					 : "r" (value), "r" (virt), "r" (AddressSpaces[ASID].descriptor));
}

/**
 * main
 */
int main(int argc, char **argv)
{
  initialize();
  int ASID = create_address_space();
  asid_mmap(ASID,((void*)4096),4096,1,1,1);
  sleep(30);
}

--------------030604040803030108020708--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
