Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4E4C2B6F.7000800@nod.at>
Date: Wed, 17 Aug 2011 22:58:23 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010707040909000705010105"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Floating point problems on UML - help needed
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, gunnarlindroth@hotmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010707040909000705010105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Gunnar reported that some Java program does not work proper within 
UserModeLinux.
After looking closer at the problem I was able to reduce it to a small C 
program. (Program is attached.)

It looks like FPU registers get sometimes lost after switching between 
two or more threads.
It also happens not always, that's why my test program contains a 
infinite loop. After a few million iterations the program abort()s.

I can reproduce the issue on both x86 and x86_64, the host's or UML's 
kernel version does not matter.
I've tested 2.6.18 to 3.1-rc2.

Interestingly the problem occurs not on my old Pentium 4 machines.
One P4 has HT the other not.
Only "newer" CPUs are affected.

First I thought it's a race in _switch_to(), but adding 
unblock/block_signals() did not help.
Currently I'm running out of ideas.
I'm not an expert in this area of UML. :-(

Any idea what goes wrong here?

Thanks,
//richard

--------------010707040909000705010105
Content-Type: text/x-csrc;
 name="fpu-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fpu-test.c"

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

static int xxx(float f)
{
	if(f <= 0.0){
		printf("wrong f!: %f\n", f);
		return -1;
	}

	return 0;
}

static void *fun(void *arg)
{
	float f = 5.0;

	for(;;){
		if(xxx(f) < 0)
			abort();
	}

	return NULL;
}

int main()
{
	pthread_t t1, t2;

	pthread_create(&t1, NULL, fun, NULL);
	pthread_create(&t2, NULL, fun, NULL);

	pthread_join(t1, NULL);
	pthread_join(t2, NULL);

	return 0;
}

--------------010707040909000705010105--
