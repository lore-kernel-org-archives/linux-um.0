Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1QIFpb-0000sb-EQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2011 07:52:11 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QIFpa-0007Lp-FY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2011 07:52:11 +0000
Received: by qyk35 with SMTP id 35so4785336qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 06 May 2011 00:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
References: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
Date: Fri, 6 May 2011 09:52:05 +0200
Message-ID: <BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] for ARCH=um,
 optionaly give a path for the vde installation.
To: paul.chavent@fnac.net
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Thu, May 5, 2011 at 9:34 AM,  <paul.chavent@fnac.net> wrote:
> Hi.
>
> I use uml with vde. The kernel links against libvdeplug.a and automatically find it. But i would like to manually give its path.
>
> So i made a patch for being able to give the VDE_PREFIX when we call make.
>
> I wonder if this patch could be included in the mainstream kernel, or if there is a better way of doing it.
>
> Could you give me your opinion please ?

Please post your patch.
Otherwise nobody can review it.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

