Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEGgp-0005tp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 15:22:23 -0800
Received: from fed1mtao07.cox.net ([68.6.19.124])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEGbJ-0004SB-D1
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 27 Oct 2003 15:16:41 -0800
Received: from easyco.com ([68.109.90.156]) by fed1mtao07.cox.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
          id <20031027231631.CCDM3394.fed1mtao07.cox.net@easyco.com>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Mon, 27 Oct 2003 18:16:31 -0500
Message-ID: <3F9DA82B.7020808@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Has anyone ever considered a COW patch for loop.c
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
Date: Mon, 27 Oct 2003 15:20:11 -0800
To: user-mode-linux-devel@lists.sourceforge.net

It would be really intersting to do a cow format compatible patch for 
loop.c so that the standard loopback device could mount cow file pairs.

Has anyone considered/started on this.  If not, I might give it a hack.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
