Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jovk8-0000RA-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 00:19:45 -0700
Received: from an-out-0708.google.com ([209.85.132.242])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jovk7-0001EG-Le
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 00:19:44 -0700
Received: by an-out-0708.google.com with SMTP id b38so807515ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Apr 2008 00:19:43 -0700 (PDT)
Message-ID: <cfa94dc20804240019g77e458e5kff3d6053800c7b5c@mail.gmail.com>
Date: Thu, 24 Apr 2008 00:19:43 -0700
From: "Ryan Finnie" <ryan@finnie.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] No SKAS3 for 2.6.25 (from me, anyway)
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
To: user-mode-linux-devel@lists.sourceforge.net

I just looked at what it would take to port SKAS3 to 2.6.25, and it
looks well beyond my C non-abilities.  Porting 2.6.23's SKAS3 to
2.6.24 was mostly an exercise in figuring out what code from
i386/x86_64 moved to where, but 2.6.24 to 2.6.25 seems to have
reworked a lot of the ptrace/ldt code.  Hopefully someone can step up
to the task.

That's not to say I won't eventually try, of course.  However, most of
my interest was vested in 2.6.24, as I wanted to upgrade my existing
UML base (based on Debian's 2.6.18 tree) to 2.6.24, as Debian will be
releasing "etchnhalf" with a 2.6.24 base.  And while it would be nice
to play with SKAS3 on a 2.6.25 host (for roughly the same reasons I
installed Red Hat Linux 5.2 as a UML guest this evening ("because I
can"; it actually works flawlessly with the latest 2.6 kernel even
though it was designed for 2.0.36)), it's not a priority for my
production guests.

RF

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
