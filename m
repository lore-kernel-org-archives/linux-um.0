Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z2nhs-0005fS-DJ
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:38:44 +0000
Received: from mail-vn0-f68.google.com ([209.85.216.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2nhr-0007OJ-Kh
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:38:44 +0000
Received: by vnbg129 with SMTP id g129so6086852vnb.0
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Jun 2015 14:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5578aab4.c66d320a.18dd.57fbSMTPIN_ADDED_BROKEN@mx.google.com>
References: <5578aab4.c66d320a.18dd.57fbSMTPIN_ADDED_BROKEN@mx.google.com>
Date: Wed, 10 Jun 2015 23:38:38 +0200
Message-ID: <CAFLxGvxcW6NvDKKW6XZYxbRtkBfWqsx+fLmssgOQ_ZDWgyYGcA@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH 3/3] um: Include sys/types.h for makedev(),
 major(), minor()
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: User-mode-linux Devel <User-mode-linux-devel@lists.sourceforge.net>

On Wed, Jun 10, 2015 at 11:21 PM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> The functions in question are not part of the POSIX standard,
> documentation however hints that the corresponding header shall
> be sys/types.h. C libraries other than glibc, namely musl, did
> not include that header via other ways and complained.

Makes sense. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

