Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z2ngi-0000mG-E4
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:37:32 +0000
Received: from mail-vn0-f66.google.com ([209.85.216.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2ngh-0007MV-OU
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:37:32 +0000
Received: by vnbf7 with SMTP id f7so6062205vnb.1
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Jun 2015 14:37:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5578aa89.c7542b0a.5b46.ffffe036SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5578aa89.c7542b0a.5b46.ffffe036SMTPIN_ADDED_BROKEN@mx.google.com>
Date: Wed, 10 Jun 2015 23:37:26 +0200
Message-ID: <CAFLxGvwfZtaTqJPRMiMbg-fmfvz0iHHNwwQJ-JR6W0DmjEvirw@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH 2/3] um: Do not use stdin and stdout names
	for variables
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: User-mode-linux Devel <User-mode-linux-devel@lists.sourceforge.net>

On Wed, Jun 10, 2015 at 11:21 PM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Naming local variables "stdin" and "stdout" is fine with glibc,
> other C libraries, namely musl, will however complain.

Wait, what?!
These are not local variables, they are struct members.

What exactly is the issue with musl? Sounds very odd.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

