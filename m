Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LnxvE-00056m-2b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 16:31:44 +0000
Received: from ti-out-0910.google.com ([209.85.142.186])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LnxvB-0000Tw-LO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 16:31:44 +0000
Received: by ti-out-0910.google.com with SMTP id b6so1325975tic.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Mar 2009 09:31:40 -0700 (PDT)
Date: Mon, 30 Mar 2009 00:32:28 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090329163228.GE7671@hack>
References: <20090204080236.GA17452@cs.unibo.it>
	<20090310214436.GC5213@cs.unibo.it> <20090316074520.GC3360@hack>
	<20090324234753.GH22695@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090324234753.GH22695@cs.unibo.it>
Subject: Re: [uml-devel] [PATCH 0/2] ptrace_vm: ptrace for syscall emulation
	virtual	machines
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, mtk.manpages@gmail.com, Am??rico Wang <xiyou.wangcong@gmail.com>, Roland McGrath <roland@redhat.com>

On Wed, Mar 25, 2009 at 12:47:53AM +0100, Renzo Davoli wrote:
>> Why not introduce a new request for PTRACE_VM but use *tags* in 'addr'?
>> We are taking risks of breaking the existing code. :)
>
>Yes, there is a minimal risk to break some code. This is a con.
>On the other side there are two main pros for this proposal:
>1- the code is now extremely simple 

Why adding a new request for ptrace is harder? I don't think so. :)


>2- if we define a different tag for syscall (e.g. PTRACE_VM), we need also
>different tags for PTRACE_VM_SINGLESTEP, PTRACE_VM_SINGLEBLOCK and maybe
>others in the future.
>Using the addr field we don't need this multiplication of tags
>(and we could soon delete PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP).
>

Yes? We could also remove PTRACE_SYSEMU* if we had PTRACE_VM to replace
it. I would like to hear more from you on this point.

Thanks.

-- 
Do what you love, f**k the rest! F**k the regulations!
 

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

