Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L7IId-0004cj-IK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Dec 2008 23:35:31 +0000
Received: from wa-out-1112.google.com ([209.85.146.176])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L7IIa-0002TE-Fy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Dec 2008 23:35:31 +0000
Received: by wa-out-1112.google.com with SMTP id m34so1585695wag.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 01 Dec 2008 15:35:26 -0800 (PST)
Message-ID: <2375c9f90812011535p667aa233u86271f07c852444@mail.gmail.com>
Date: Mon, 1 Dec 2008 23:35:26 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
In-Reply-To: <20081130030128.GA8948@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<2375c9f90811290503s1b4cb9aelaecccc680c6e37d0@mail.gmail.com>
	<20081130030128.GA8948@balbir.in.ibm.com>
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
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
To: balbir@linux.vnet.ibm.com, Am?rico Wang <xiyou.wangcong@gmail.com>, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Nov 30, 2008 at 3:01 AM, Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
>
> I did not fix that with UNIX_PATH_MAX since, mconsole_user.c already includes
> sys/un.h and sys/socket.h and I did not want to include kernel headers
> linux/socket.h and linux/un.h there. I could have hard-coded those
> values to 108, but I just let it be for now. If you feel strongly
> about it, it can be done.
>

No, you can leave it to me. :)

Thanks.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
