Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z2nf7-0005U1-AG
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:35:53 +0000
Received: from mail-vn0-f65.google.com ([209.85.216.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2nf6-0007Je-Nh
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:35:53 +0000
Received: by vnbf190 with SMTP id f190so6049413vnb.2
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Jun 2015 14:35:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5578aa6d.417c320a.2479.4260SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5578aa6d.417c320a.2479.4260SMTPIN_ADDED_BROKEN@mx.google.com>
Date: Wed, 10 Jun 2015 23:35:47 +0200
Message-ID: <CAFLxGvwpqYfBD-KFcp2jX9MZwAL8ZrrCOoyJC5xb6J+t8DJpRQ@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH 1/3] um: Fallback when C library does not
 provide __ptr_t
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <User-mode-linux-devel@lists.sourceforge.net>

On Wed, Jun 10, 2015 at 11:20 PM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Glibc provides __ptr_t for the pointer in the stack_t struct,
> but other C libraries - namely musl - do not necessarily do so.
> In that case, fall back to a void* pointer.

Please just kill __ptr_t in UML.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

