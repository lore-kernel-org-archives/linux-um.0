Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACwGL-0007la-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 00:21:33 -0700
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACjyy-0006zp-0i
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 11:14:48 -0700
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 3D44937A
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 14:11:45 -0400 (EDT)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1ACjw0-0007hx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 14:11:44 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] uml_switch
Message-ID: <20031023181144.GU1538@dijkstra.csh.rit.edu>
References: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 23 Oct 2003 14:11:44 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 23, 2003 at 07:55:24AM -0300, Nelio Pereira wrote:

> I would like to know where in the uml_switch code is the best place to do
> that. Actually, I'd like to intercept those messages in a place where I
> could know the sender and recipient IP of each message.

I haven't checked the code, but I don't think that uml_switch decodes the IP
header at all; it only deals with Ethernet frames.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
