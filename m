Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2w5Q-0004Jb-0y
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 06:35:36 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2w5M-0002yu-5V
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 06:35:36 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1Z2w52-0001Aq-CA
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 08:35:12 +0200
MIME-Version: 1.0
Date: Thu, 11 Jun 2015 08:35:12 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <CAFLxGvwfZtaTqJPRMiMbg-fmfvz0iHHNwwQJ-JR6W0DmjEvirw@mail.gmail.com>
References: <5578aa89.c7542b0a.5b46.ffffe036SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAFLxGvwfZtaTqJPRMiMbg-fmfvz0iHHNwwQJ-JR6W0DmjEvirw@mail.gmail.com>
Message-ID: <6e13f3aadfb37a3593bd0a29d70af17c@hilses.de>
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
To: User-mode-linux Devel <User-mode-linux-devel@lists.sourceforge.net>

Hi,

Am 2015-06-10 23:37, schrieb Richard Weinberger:
> On Wed, Jun 10, 2015 at 11:21 PM, Hans-Werner Hilse <hwhilse@gmail.com> 
> wrote:
>> Naming local variables "stdin" and "stdout" is fine with glibc,
>> other C libraries, namely musl, will however complain.
> 
> Wait, what?!
> These are not local variables, they are struct members.
> 
> What exactly is the issue with musl? Sounds very odd.

They chose to have stdin and stdout (and, of course, stderr) wrapped in 
macros - in a different way than glibc:

[...]
   extern FILE *const stdin;
[...]
   #define stdin  (stdin)

(http://git.musl-libc.org/cgit/musl/tree/include/stdio.h?id=v1.1.10#n59)

The C standards C89/C99 (the last one I even looked up right now) say 
those identifiers are macros - according to stdio.h from glibc, which 
does the following:

   /* Standard streams.  */
   extern struct _IO_FILE *stdin;          /* Standard input stream.  */
[...]
   /* C89/C99 say they're macros.  Make them happy.  */
   #define stdin stdin
[...]

Of course you're right, of course they are struct members. That's what I 
get for writing my commit messages too long after going at the issue at 
hand.

I'll send an updated patch series in a few minutes.

Thanks for getting back and caring!

-hwh

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

