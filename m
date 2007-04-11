Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbgG1-0000LN-GA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 10:05:21 -0700
Received: from wr-out-0506.google.com ([64.233.184.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HbgG1-0000iT-25
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 10:05:21 -0700
Received: by wr-out-0506.google.com with SMTP id i4so188401wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Apr 2007 10:05:17 -0700 (PDT)
Message-ID: <75b57c110704111005w6b605d0cv921f3b2c6a6c4eae@mail.gmail.com>
Date: Wed, 11 Apr 2007 13:05:16 -0400
From: "Gerb Stralko" <gerb.stralko@gmail.com>
In-Reply-To: <20070411160126.GA6324@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <20070411160126.GA6324@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 2/4] UML - Send pointers instead of
	structures to I/O thread
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 4/11/07, Jeff Dike <jdike@addtoit.com> wrote:
> Instead of writing entire structures between UML and the I/O thread,
> we send pointers.  This cuts down on the amount of data being copied
> and possibly allows more requests to be pending between the two.
<snip>
>
> -                       n = os_write_file_k(thread_fd, (char *) &io_req,
> -                                           sizeof(io_req));
> -                       if(n != sizeof(io_req)){
> +                       n = os_write_file_k(thread_fd, &io_req,
> +                                           sizeof(struct io_thread_req *));
> +                       if(n != sizeof(struct io_thread_req *)){

Is this wrong?  you declare io_reg as a pointer but then you pass him
to os_write_file_k by  reference of a pointer? Should you just do this
instead:

> +                       n = os_write_file_k(thread_fd, io_req,
> +                                           sizeof(struct io_thread_req *));

Was this intentional, or am I just an idiot. :)

-Jerry

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
