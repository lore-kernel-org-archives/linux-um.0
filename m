Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7KlI-00027L-Aj	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 15:27:24 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E7KlG-0000vY-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 15:27:24 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: madvise(DONTNEED) on tmpfs pages instead of
	/dev/anon
Message-ID: <20050822202402.GA27051@ccure.user-mode-linux.org>
References: <200508102136.43763.blaisorblade@yahoo.it>
	<20050812163817.GA7448@ccure.user-mode-linux.org>
	<200508121900.26503.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508121900.26503.blaisorblade@yahoo.it>
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
Date: Mon, 22 Aug 2005 16:24:02 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Rik van Riel <riel@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 12, 2005 at 07:00:26PM +0200, Blaisorblade wrote:
> Yes, but for the VM, there is nothing else than pagecache and swapcache and 
> swap entries. Since that call will drop them, on normal files backing store 
> will remain, on tmpfs everything will vanish!
> 
> Hope you'll implement this soon, if it works.

There was a small omission in my quick analysis, which you alluded to above.

It's removed from the address space, but preserved in the page cache.

Run the test below to see this.

With a tmpfs /tmp, MADV_DONTNEED preserves the data.

				Jeff

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/param.h>
#include <sys/mman.h>
#include <asm/page.h>

int main(int argc, char **argv)
{
	int fd, i;
	unsigned char *addr, c = 0xff;

	fd = open("/tmp/test", O_RDWR | O_CREAT);
	if(fd < 0){
		perror("Opening /tmp/test");
		exit(1);
	}

	for(i = 0; i < PAGE_SIZE; i++)
		write(fd, &c, 1);
	close(fd);

	fd = open("/tmp/test", O_RDWR);
	if(fd < 0){
		perror("Opening /tmp/test for mmap");
		exit(1);
	}

	addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE,
		    fd, 0);
	if(addr == MAP_FAILED){
		perror("mmapping test file 1");
		exit(1);
	}
		
	for(i = 0; i < PAGE_SIZE; i++){
		if(addr[i] != 0xff){
			printf("First mmap - bytes not == 0xff\n");
			exit(1);
		}
	}

	if(madvise(addr, PAGE_SIZE, MADV_DONTNEED) < 0){
		perror("MADV_DONTNEED");
		exit(1);
	}


	munmap(addr, PAGE_SIZE);

	addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE,
		    fd, 0);
	if(addr == MAP_FAILED){
		perror("mmapping test file 2");
		exit(1);
	}

	for(i = 0; i < PAGE_SIZE; i++){
		if(addr[i] != 0xff){
			printf("Second mmap - bytes not == 0xff\n");
			exit(1);
		}
	}

	printf("Data was preserved across MADV_DONTNEED\n");
}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
