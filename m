Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ahlongxp@gmail.com>) id 1LP6Bp-0007Ud-97
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 02:18:05 +0000
Received: from rv-out-0708.google.com ([209.85.198.243])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LP6Bg-0001uI-DG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 02:18:05 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3002624rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2009 18:17:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090119152104.GC6432@c2.user-mode-linux.org>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
Date: Tue, 20 Jan 2009 09:46:15 +0800
Message-ID: <dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
From: Daolong Wang <ahlongxp@gmail.com>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org

On Mon, Jan 19, 2009 at 11:21 PM, Jeff Dike <jdike@addtoit.com> wrote:
> On Sun, Jan 18, 2009 at 02:23:46PM +0800, Daolong Wang wrote:
>> I can confirm this link error.
>
> In what environment?  I see no problems here.
>
Ubuntu 8.04. Gcc is 4.2.4. Sorry I don't have the access to the machine now.
>> And this patch works for me.
>
> Maybe it fixes the link failure.  But I really doubt that sigprocmask works.
>
not sure. compile test only!
>                                Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
