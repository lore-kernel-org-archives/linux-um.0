Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYkoN-0004Ro-1V for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 05:07:07 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BYkoM-0003cl-EU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 05:07:06 -0700
Message-ID: <1081.83.109.37.51.1086955616.squirrel@nepa.nlc.no>
In-Reply-To: <40C99B22.2010709@auto.ucl.ac.be>
References: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no> 
	<40C99B22.2010709@auto.ucl.ac.be>
Subject: Re: [uml-devel] Hi people. A kernel bug in the vanilla kernel
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Fri, 11 Jun 2004 14:06:56 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Thanks people. If the world was perfect the code should run forever
without problems, but floating point exception is better than machine
freeze as happens outside UML on all machines tested except one by my
buddies.

Something is very wrong running that test, atleast when running on the
main host, and not inside UML. :-)


Stian


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
