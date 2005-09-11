Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEMFF-0007XW-Fe	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Sep 2005 00:27:21 -0700
Received: from ms004msg.fastwebnet.it ([213.140.2.58])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EEMFD-0004l6-VV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Sep 2005 00:27:21 -0700
From: Paolo Ornati <ornati@fastwebnet.it>
Message-ID: <20050911092802.1ab931ac@localhost>
In-Reply-To: <Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan>
	<20050910174630.063774000@zion.home.lan>
	<Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 7/7] uml: retry host close() on EINTR
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 11 Sep 2005 09:28:02 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, 10 Sep 2005 12:00:01 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Re-doing the close() is the wrong thing to do, since in a threaded 
> environment, something else might have opened another file, gotten
> the same file descriptor, and you now close _another_ file.

So glibc doc is wrong here:

http://www.gnu.org/software/libc/manual/html_node/Opening-and-Closing-Files.html#index-close-1197

-----------------------------------------------------------------------
The normal return value from close is 0; a value of -1 is returned in
case of failure. The following errno error conditions are defined for
this function:

...

EINTR
    The close call was interrupted by a signal. See Interrupted
Primitives. Here is an example of how to handle EINTR properly:

               TEMP_FAILURE_RETRY (close (desc));
-----------------------------------------------------------------------


And: /usr/include/unistd.h

# define TEMP_FAILURE_RETRY(expression)		\
  (__extension__				\
    ({ long int __result;			\
       do __result = (long int) (expression);	\
       while (__result == -1L && errno == EINTR); \
       __result; }))
#endif


SUSV3:
-------------------------------------------------------------
If close() is interrupted by a signal that is to be caught, it shall
return -1 with errno set to [EINTR] and the state of fildes is
unspecified
-------------------------------------------------------------

Unspecified! ;-)

-- 
	Paolo Ornati
	Linux 2.6.13.1 on x86_64


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
