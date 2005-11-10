Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ea3XH-0002yl-1x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:55:39 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ea3XG-0006Vs-PP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:55:39 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511081835.47575.rob@landley.net>
	<20051110040708.GC15002@ccure.user-mode-linux.org>
In-Reply-To: <20051110040708.GC15002@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wSscDR2ex3w1/My"
Message-Id: <200511092155.28199.rob@landley.net>
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
Date: Wed, 9 Nov 2005 21:55:27 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: Can Sar <csar@stanford.edu>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_wSscDR2ex3w1/My
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 09 November 2005 22:07, Jeff Dike wrote:
> On Tue, Nov 08, 2005 at 06:35:47PM -0600, Rob Landley wrote:
> > Jeff was going to split out the scheduler and filesystem into shared
> > libraries or some such.  He mentions it in his intermittent diary, among
> > other places.
>
> This has nothing to do with that.

Ok.

> One of my other future projects is embedding UML into other things, as in
> a library, to give those other processes access to functionality like
> clustering.

You've mentioned this before.  I've never quite been able to visualize what it 
is you want to do.  (Embed UML to give processes access to functionality like 
clustering...  Nope, I still don't get it.  Can you give a more concrete 
example?)

> In this case, you may not want UML booting to userspace - you 
> just want the kernel initialized enough that you can call into it.

My normal use case for UML involves an init that's either a command shell or a 
shell script, so I'm used to there often only being one process on the 
system.  (I even made a dumb little "oneit.c", attached, that runs one 
process and then shuts down when that process exits, and sets up everything 
so ctrl-c works in that process.)

I.E.

./linux rootfstype=hostfs rw init=/path/to/oneit /bin/sh

And then once you've got your command shell in UML, you can insmod a module 
that calls or prints out whatever you need, while the init process can block 
indefinitely and there are no other tasks running.  So I've never had too 
much trouble accessing the sucker's internals when I wanted to do so, in an 
otherwise quiescent system.  (Usually I just stick printfs into the sucker, 
though.  It's just so easy...)

Rob

--Boundary-00=_wSscDR2ex3w1/My
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="oneit.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oneit.c"

/* oneit.c, tiny one-process init replacement.
 *
 * Copyright 2005 by Rob Landley.  Released under gpl v2.
 */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/reboot.h>

// World's most brain-dead init program.  Does the minimum amount of work
// necessary to get ctrl-c and such to work.
//
// Fork a child (PID 1 is special: it can't exit and has various signals
// blocked).  In the child, attach stdio to /dev/tty0 (so we have a controlling
// tty, plus do a setsid()), then exec the rest of the command line.
//
// PID 1 then reaps zombies until the child process it spawned exits, at which
// point it calls sync() and reboot().

int main(int argc, char *argv[])
{
  int a;
  pid_t pid;
  
  // pid 1 just reaps zombies until it gets its child, then halts the system.
  pid=fork();
  if(pid) {
    while(pid!=wait());
    sync();
    reboot(LINUX_REBOOT_CMD_HALT);
  }
    
  // Redirect stdio to /dev/tty0, with new session ID, so ctrl-c works.
  setsid();
  for(a=0;a<3;a++) {
    close(a);
    open("/dev/tty0",O_RDWR);
  }
  
  execvp(argv[1],argv+1);
}

--Boundary-00=_wSscDR2ex3w1/My--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
