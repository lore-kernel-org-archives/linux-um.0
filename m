Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z2yQU-0006aB-Kx
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:05:30 +0000
Received: from mail-vn0-f46.google.com ([209.85.216.46])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2yQT-0008Qg-Qi
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:05:30 +0000
Received: by vnbf190 with SMTP id f190so138647vnb.5
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 02:05:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f8c70b0b8c5e2ceb7a65929ceb4d17a9@hilses.de>
References: <5578aa89.c7542b0a.5b46.ffffe036SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAFLxGvwfZtaTqJPRMiMbg-fmfvz0iHHNwwQJ-JR6W0DmjEvirw@mail.gmail.com>
	<6e13f3aadfb37a3593bd0a29d70af17c@hilses.de>
	<CAFLxGvy8DW2OPZY4BZVsG6GaQKw0i-V4oZqmRjOay5rmw392fA@mail.gmail.com>
	<d99580704680b019f8fe728c0094832d@hilses.de>
	<CAFLxGvyQuZ6aFZ3rVYT1v23nvVrTdx6vceKym1sHs3Brm_oc0A@mail.gmail.com>
	<f8c70b0b8c5e2ceb7a65929ceb4d17a9@hilses.de>
Date: Thu, 11 Jun 2015 11:05:24 +0200
Message-ID: <CAFLxGvx0CngPJydEaU1QYo+NLZ9b1q-nh41ZUY8REr8z3vSJPw@mail.gmail.com>
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

On Thu, Jun 11, 2015 at 10:26 AM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Am 2015-06-11 10:09, schrieb Richard Weinberger:
>> On Thu, Jun 11, 2015 at 9:54 AM, Hans-Werner Hilse <hwhilse@gmail.com>
>> wrote:
>>> About forbidden use of names/identifiers from the stdlib, the C
>>> standard
>>> is a bit hard for me to grasp fully. However, I think C99 7.1.3
>>> paragraph 1, 3rd point is relevant here: "Each macro name in any of
>>> the
>>> following subclauses (including the future library directions) is
>>> reserved for use as specified if any of its associated headers is
>>> included; unless explicitly stated otherwise (see 7.1.4)."
>>
>> Yeah, but we're talking about structure members.
>
> Indeed, and I can't find more detail about the "reserved for use as
> specified" part.
> I think it is saying, though, that those identifiers are macros (and as
> such will get expanded). The preprocessor will not care if that's in a
> struct member name.

While I think musl could be more user friendly,
I fear the easiest solution is really to rename our structure members.
glibc does a the user a favor by having a simple "#define stdin stdin".

>>> So aside from renaming struct members, another option would be to lift
>>> the macro definition by an "#undef" in relevant places. I have a
>>> feeling, though, that this faces new problems with the C99 standard,
>>> 7.1.3 paragraph 3, which says that "If the program removes (with
>>> #undef)
>>> any macro definition of an identifier in the first group listed above,
>>> the behavior is undefined."
>>
>> So, what exactly is the build error you're facing and how can I
>> reproduce?
>
> Of course I should have told you in the first place:
>
> [hw@hilses linux-uml]$ make ARCH=um CC="musl-gcc"

Thx!

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

