Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magotari@gmail.com>) id 1L0VwO-0007uZ-Jw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 06:44:32 +0000
Received: from yx-out-1718.google.com ([74.125.44.155])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0VwN-0004UD-7V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 06:44:32 +0000
Received: by yx-out-1718.google.com with SMTP id 3so324388yxi.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Nov 2008 22:44:29 -0800 (PST)
Message-ID: <ea9232d10811122244w52c90a48r81a7e0210c84df94@mail.gmail.com>
Date: Wed, 12 Nov 2008 22:44:24 -0800
From: "Karol Swietlicki" <magotari@gmail.com>
In-Reply-To: <804dabb00811122239l352dbb5dta63dc3330b92bf5a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00811122239l352dbb5dta63dc3330b92bf5a@mail.gmail.com>
Subject: Re: [uml-devel] query on STDERR output from UML tracing
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
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 12/11/2008, Peter Teoh <htmldeveloper@gmail.com> wrote:
> As I used gdb to trace UML execution, only three lines were output to
> STDERR:
>
>   - /proc/mm...not found: No such file or directory
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
>
> What are these?   How to turn them on?   What is the implication of
> not having these features?

Those lines mean that you do not have SKAS3/4 patches in your kernel.
They are not essential for UML, but having them can give you a
performance boost.

Karol Swietlicki

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
