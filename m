Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzjPO-0001I2-Vu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 15:41:38 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzjPN-0007g6-IO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 15:41:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared"
	bogus error messages
References: <20060118235132.4626.74049.stgit@zion.home.lan>
	<200601191601.31805.blaisorblade@yahoo.it>
	<20060119194356.GA8670@ccure.user-mode-linux.org>
In-Reply-To: <20060119194356.GA8670@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601200041.14590.blaisorblade@yahoo.it>
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
Date: Fri, 20 Jan 2006 00:41:08 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 19 January 2006 20:43, Jeff Dike wrote:
> On Thu, Jan 19, 2006 at 04:01:28PM +0100, Blaisorblade wrote:
> > Gerd Knorr in his tty patch, instead, used forward declarations, like:
> >
> > struct task_struct;
> >
> > what about that?

> I don't think so.  At least when you use void *, you are using a type
> that's not incorrect.  In userspace code, those task_structs start
> referring to host task_structs, which is definitely very wrong.

Possibly yes, but as long as we don't dereference the pointer (and in a 
prototype you're not going to do that) there's no problem.

Using a type makes the code clearer, and it doesn't hide any warning GCC may 
give (behaving well is left to us only).

In fact, btw (before I forget) we have currently the wrong errno used in 
sys-i386/ldt.c. Just wrote the fix (it's adding a silly os_ptrace_ldt). Going 
to compile and send.

> > Those functions probably should be moved anyway because they're
> > useless there

> Yeah.

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
