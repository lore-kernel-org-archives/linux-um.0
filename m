Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACdVE-00005y-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 04:19:40 -0700
Received: from web20201.mail.yahoo.com ([216.136.226.56])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACd9l-0000Er-Nz
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 03:57:29 -0700
Message-ID: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
From: =?iso-8859-1?q?Nelio=20Pereira?= <nelio_pereira@yahoo.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] uml_switch
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
Date: Thu, 23 Oct 2003 07:55:24 -0300 (ART)
To: user-mode-linux-devel@lists.sourceforge.net

Hi list..

I'm using UML to benchmark a distributed protocol
(cluster membership service) on a virtual network. As
a way of injecting faults, I thought about changing
uml_switch so it would not forward every message it
receives. Roughly speaking, it could deliver only a
percentage of the messages. 

I would like to know where in the uml_switch code is
the best place to do that. Actually, I'd like to
intercept those messages in a place where I could know
the sender and recipient IP of each message.

Thanks,

Nelio

=====
+------------------------------------------------------------------------+
                       http://www.ime.usp.br/~nelio

Yahoo! Mail - o melhor webmail do Brasil
http://mail.yahoo.com.br


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
