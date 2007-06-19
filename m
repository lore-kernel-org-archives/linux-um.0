Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I0irJ-0006xv-PA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 11:55:26 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I0irJ-00034w-J3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 11:55:21 -0700
Date: Tue, 19 Jun 2007 11:54:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070619115422.de61abd5.akpm@linux-foundation.org>
In-Reply-To: <20070619184245.GA10567@c2.user-mode-linux.org>
References: <20070619184245.GA10567@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 19 Jun 2007 14:42:45 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> Add a machanism to see how much of a kernel stack is used.  This
> allocates zeroed stacks and sees where the lowest non-zero byte is on
> process exit.  It keeps track of the lowest value and logs values as
> they get lower.
> 

remind us again why the generic code is unsuitable?

> +	for(p = stack; p < end; p++){
> +		if(*p != 0)
> +	if(left < lowest_to_date){

Are there any plans to fix UML coding style?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
