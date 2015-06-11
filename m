Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z2xYp-0002GG-52
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 08:10:03 +0000
Received: from mail-vn0-f47.google.com ([209.85.216.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2xYo-0008U3-2j
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 08:10:03 +0000
Received: by vnbg62 with SMTP id g62so11692037vnb.4
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 01:09:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d99580704680b019f8fe728c0094832d@hilses.de>
References: <5578aa89.c7542b0a.5b46.ffffe036SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAFLxGvwfZtaTqJPRMiMbg-fmfvz0iHHNwwQJ-JR6W0DmjEvirw@mail.gmail.com>
	<6e13f3aadfb37a3593bd0a29d70af17c@hilses.de>
	<CAFLxGvy8DW2OPZY4BZVsG6GaQKw0i-V4oZqmRjOay5rmw392fA@mail.gmail.com>
	<d99580704680b019f8fe728c0094832d@hilses.de>
Date: Thu, 11 Jun 2015 10:09:56 +0200
Message-ID: <CAFLxGvyQuZ6aFZ3rVYT1v23nvVrTdx6vceKym1sHs3Brm_oc0A@mail.gmail.com>
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

On Thu, Jun 11, 2015 at 9:54 AM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Am 2015-06-11 08:49, schrieb Richard Weinberger:
>> On Thu, Jun 11, 2015 at 8:35 AM, Hans-Werner Hilse <hwhilse@gmail.com>
>> wrote:
>>> Hi,
>>>
>>> Am 2015-06-10 23:37, schrieb Richard Weinberger:
>>>> On Wed, Jun 10, 2015 at 11:21 PM, Hans-Werner Hilse
>>>> <hwhilse@gmail.com>
>>>> wrote:
>>>>> Naming local variables "stdin" and "stdout" is fine with glibc,
>>>>> other C libraries, namely musl, will however complain.
>>>>
>>>> Wait, what?!
>>>> These are not local variables, they are struct members.
>>>>
>>>> What exactly is the issue with musl? Sounds very odd.
>>>
>>> They chose to have stdin and stdout (and, of course, stderr) wrapped
>>> in
>>> macros - in a different way than glibc:
>>>
>>> [...]
>>
>> Slow down a bit. Since when is it forbidden to name something "stdin"
>> in a C
>> program? Does the standard say that? If yes, where?
>> We have to sort this out. If UML violates a rule, we have to fix it.
>> But maybe musl needs fixing...
>
> Digging further, I think I cannot better describe the issue than Rich
> Felker did in this message:
> http://lists.cs.uiuc.edu/pipermail/llvm-commits/Week-of-Mon-20130506/173690.html
>
>> Per ISO C, stdin, stdout, and stderr are macros "which are expressions
>> of type ''pointer to FILE'' that point to the FILE objects associated,
>> respectively, with the standard error, input, and output streams."
>> (C99 7.19.1 paragraph 3). They are not necessarily objects, merely
>> expressions, and as such, taking their address is invalid.
>
> That last sentence, however, does not apply to the problem I'm facing
> with UML and musl. Here, the problem is actually that the
> stdin/stdout/stderr identifiers are per the C standard predefined as
> being macros.
>
> In the glibc case, it won't break anyway since the macro definition is
> tight enough to mask the problem. For musl, the macro definition is
> minimally more complex and the result is a macro expansion that leaves
> syntactically incorrect code. In the past - see the linked discussion -
> musl developers stressed that their implementation is conformant to the
> standard.
>
> About forbidden use of names/identifiers from the stdlib, the C standard
> is a bit hard for me to grasp fully. However, I think C99 7.1.3
> paragraph 1, 3rd point is relevant here: "Each macro name in any of the
> following subclauses (including the future library directions) is
> reserved for use as specified if any of its associated headers is
> included; unless explicitly stated otherwise (see 7.1.4)."

Yeah, but we're talking about structure members.

> So aside from renaming struct members, another option would be to lift
> the macro definition by an "#undef" in relevant places. I have a
> feeling, though, that this faces new problems with the C99 standard,
> 7.1.3 paragraph 3, which says that "If the program removes (with #undef)
> any macro definition of an identifier in the first group listed above,
> the behavior is undefined."

So, what exactly is the build error you're facing and how can I reproduce?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

