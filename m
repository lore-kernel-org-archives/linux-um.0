Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ8il-0003vD-05 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:49:43 -0700
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BQ8ik-0007WO-QY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:49:42 -0700
Received: from stclair.eecs.umich.edu (localhost.eecs.umich.edu [127.0.0.1])
	by stclair.eecs.umich.edu (8.12.10/8.12.10) with ESMTP id
	i4IHnebu008106 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 13:49:40 -0400
Received: from localhost (dunlapg@localhost)
	by stclair.eecs.umich.edu (8.12.10/8.12.10/Submit) with ESMTP id
	i4IHnelW008102 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 13:49:40 -0400
From: George Washington Dunlap III <dunlapg@umich.edu>
Message-ID: <Pine.LNX.4.60.0405181335300.4190@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Native drivers for UML
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
Date: Tue, 18 May 2004 13:49:40 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

I'm looking into doing (host) device driver debugging w/ UML.  I'd seen 
some references to it in different places, but nothing with any solid 
leads.  Is anyone still doing this?  Are there any old patches / example 
device drivers out there?  Any pitfalls or traps I can avoid?

Thanks,
  -George

+-------------------+----------------------------------------
| dunlapg@umich.edu | http://www-personal.umich.edu/~dunlapg 
+-------------------+----------------------------------------
|  Who could move a mountain, who could love their enemy?
|  Who could rejoice in pain, and turn the other cheek?
|	- Rich Mullins, "Surely God is With Us"
+------------------------------------------------------------
| Outlaw Junk Email! Support HR 1748 (www.cauce.org)


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
