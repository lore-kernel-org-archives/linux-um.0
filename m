Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BI6S8-0003XI-6x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Apr 2004 06:47:20 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BI6S7-0005fU-U5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Apr 2004 06:47:19 -0700
Message-ID: <20040426134657.24368.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Still can't get an 2.6.6-rcX UML
Content-Type: Text/Plain;
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
Date: 26 Apr 2004 13:46:57 -0000
To: jeff98@silk.corp.fedex.com
Cc: user-mode-linux-devel@lists.sourceforge.net

jeff98@silk.corp.fedex.com wrote:

> 

> can you disable smp and high mem. Try my .config (uml) attached.

> 



Ummm... Did you look at the .config I attached to that e-mail?



#

# UML-specific options

#

...

# CONFIG_UML_SMP is not set

# CONFIG_SMP is not set

...

# CONFIG_HIGHMEM is not set



Note that SMP & High Mem are disabled.



I'll try your .config and let you know.



George



-----------------------------------------------

Get your FREE Christian Email Account at Praize

http://www.praize.com/email/ 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
