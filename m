Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1b47dt-0005ft-Kl
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 14:12:37 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b47ds-0001Qv-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 14:12:37 +0000
References: <1463839418-22282-1-git-send-email-vegard.nossum@oracle.com>
	<CACT4Y+ZprkvUgxy7tx2OpAOi636=VN=88dMAMuBrv_ZQ0YPeyw@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <57406CC7.8060804@oracle.com>
Date: Sat, 21 May 2016 16:12:23 +0200
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZprkvUgxy7tx2OpAOi636=VN=88dMAMuBrv_ZQ0YPeyw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: support kcov
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

On 05/21/2016 04:05 PM, Dmitry Vyukov wrote:
> On Sat, May 21, 2016 at 4:03 PM, Vegard Nossum <vegard.nossum@oracle.com
> <mailto:vegard.nossum@oracle.com>> wrote:
>
>     This adds support for kcov to UML.
>
[...]
> Acked-by: Dmitry Vyukov <dvyukov@google.com <mailto:dvyukov@google.com>>
>
> Cool! How do you plan to use it?

We have a patch for kcov itself adding the AFL mode coming up very soon
:-) We've been doing almost all our filesystem (and other) AFL fuzzing
in UML instances as we found it gave a really big performance boost over
KVM.


Vegard

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

