Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jyunz-0007WN-NF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 13:20:59 -0700
Received: from gv-out-0910.google.com ([216.239.58.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jyuny-00009R-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 13:20:59 -0700
Received: by gv-out-0910.google.com with SMTP id i36so858528gve.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 May 2008 13:20:55 -0700 (PDT)
Message-ID: <48348417.9090103@googlemail.com>
Date: Wed, 21 May 2008 22:20:39 +0200
From: Gabriel C <nix.or.die@googlemail.com>
MIME-Version: 1.0
References: <48345B31.50904@googlemail.com>
	<20080521200515.GB12373@c2.user-mode-linux.org>
In-Reply-To: <20080521200515.GB12373@c2.user-mode-linux.org>
Subject: [SPAM]  Re: [uml-devel] linux-next: UML build error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-next@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> On Wed, May 21, 2008 at 07:26:09PM +0200, Gabriel C wrote:
>>   CC      arch/um/sys-x86_64/ksyms.o
>> arch/um/sys-x86_64/ksyms.c:5: error: '__memcpy' undeclared here (not in a function)
>> arch/um/sys-x86_64/ksyms.c:5: warning: type defaults to 'int' in declaration of '__memcpy'
> 
> Does the patch below help?  There's gcc-version-dependent logic in
> include/asm-x86/string_64.h which decides whether to declare memcpy or
> __memcpy and it looks like you're hitting that.


Yes is fixes this error , however I get now another one but this one seems to be an compiler bug.

...
 CC      arch/um/sys-x86_64/um_module.o
  LD      arch/um/sys-x86_64/subarch.o
  LD      arch/um/sys-x86_64/built-in.o
  LD      arch/x86/crypto/built-in.o
  CC      kernel/sched.o
In file included from kernel/sched.c:1842:
kernel/sched_idletask.c: In function 'check_preempt_curr_idle':
kernel/sched_idletask.c:20: internal compiler error: in cgraph_estimate_size_after_inlining, at ipa-inline.c:188

...

This is gcc 4.3.0 ( with backports of some known fixed bugs ).
I try to build latest snapshot of gcc 4.3* later on today and try with this one. 

> 
> 	     	      Jeff
> 



Gabriel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
