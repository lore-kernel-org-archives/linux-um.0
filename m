Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GnVVd-0008JG-Fp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Nov 2006 23:30:05 -0800
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GnVVd-0003KC-1P
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Nov 2006 23:30:05 -0800
Received: by nf-out-0910.google.com with SMTP id c31so1778298nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 23 Nov 2006 23:30:03 -0800 (PST)
Message-ID: <22a33e9f0611232330l5c8e7952k177a6d0081e93833@mail.gmail.com>
Date: Fri, 24 Nov 2006 07:30:03 +0000
From: "Matt Willsher" <matt@monki.org.uk>
In-Reply-To: <22a33e9f0611232329g6c8a8614x3472a0da3416aba5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
	<22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
	<200611220122.24515.blaisorblade@yahoo.it>
	<22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
	<20061122164446.GB5120@ccure.user-mode-linux.org>
	<22a33e9f0611232329g6c8a8614x3472a0da3416aba5@mail.gmail.com>
Subject: [uml-devel] Fwd: Re: Re: Problem with newer (>2.6.14) UML kernels
	hanging under Xen DomU/Centos 4.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On 11/22/06, Jeff Dike <jdike@addtoit.com> wrote:
> On Wed, Nov 22, 2006 at 08:04:59AM +0000, Matt Willsher wrote:
> > UML running in TT mode
>
> Sorry about that last suggestion - I missed that you were trying an
> old UML.

The TT mode on my last mail was on the latest kernel (2.6.18.3) with
the BB patch sets applied. I recompiled with TT disabled and let it
run in SKAS0 mode and it hung as per my initial mail.

> I have to repeat what BB said about the "init not found" error.  I
> never seen that not be a filesystem problem.  Can you try booting that
> filesystem in an environment which is known to work, to make sure that
> it is sane?

This was only in TT mode on the most recent kernel. The image I was
using was one that I am successfully using under 2.6.12.6-bs11.

I've not tried 2.6.13 or 2.6.14 again in TT mode, but I'm not sure
what that would prove? If it would aid in troubleshooting the problem
of running under the latest kernel in SKAS0 mode, give TT mode on the
new kernels is obsolete, I am of course happy to try that.

My initial searching into this problem returned a reference to a VDSO
issue, which is also documented on the new site on the problems page.
I'm not sure if this could be the cause of the problem as the UML I'm
running is under a Xen DomU, and I have no control over this kernel
and /proc/config.gz is not available.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
