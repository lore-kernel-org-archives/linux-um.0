Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZwFSr-0002DA-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Nov 2015 20:24:25 +0000
Received: from mail-oi0-f45.google.com ([209.85.218.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZwFSq-0008GO-Mu
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Nov 2015 20:24:25 +0000
Received: by oiad129 with SMTP id d129so4881597oia.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Nov 2015 12:24:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56423A89.2040206@kot-begemot.co.uk>
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
	<5640B5B5.7050907@kot-begemot.co.uk>
	<56423A89.2040206@kot-begemot.co.uk>
Date: Tue, 10 Nov 2015 21:24:19 +0100
Message-ID: <CAFLxGvx-F1hU8DgrSwBgvbwDFzrz2R5cW-ZSJ0ymazj3jxb6wg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2] EPOLL Interrupt Controller V2.0
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Nov 10, 2015 at 7:42 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Thomas Mayer found a couple of issues which crept up when porting v1 to
> the newer kernels.
>
> It also crashes with his config - I am analyzing the differences between
> that and mine to find the culrpit.
>
> Once I have fixed both I will resubmit v3. So for now this is just
> "subject for discussion", do not use yet.

There is no need to hurry. :-)
This is 4.5 material.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

