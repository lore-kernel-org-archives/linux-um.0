Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGz4l-00037e-3X for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 08:28:27 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGz4j-0007aY-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 08:28:27 -0700
Date: Fri, 3 Aug 2007 11:28:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070803152817.GA7242@c2.user-mode-linux.org>
References: <E1IGvaz-0005Gq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IGvaz-0005Gq-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] UML: write errors on terminal
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 03, 2007 at 01:45:29PM +0200, Miklos Szeredi wrote:
> I get errors in uml when writing to the xterm console.  For example if I do
> 
> $ cat bigfile
> [some output]
>   cat: write error: Operation not permitted
> 
> This is 2.6.23-rc1-mm2, I haven't yet checked other versions.

Rats, I fixed generic_read, but totally didn't look at generic_write.

A patch is forthcoming...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
