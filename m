Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AkL9x-0004BS-Q0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 02:37:01 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AkFwG-0003vX-1H
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 21:02:32 -0800
Received: from localhost ([127.0.0.1]:34257 helo=shearer.org)
	by shearer.org with esmtp (Dan's MTA 1.0) id 1AkFyM-0005dr-11
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 15:34:42 +1030
Received: from dan by erizo.shearer.org with local (Spammer Slammer 3.141)
	id 1AkFyK-0005do-Le for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 15:34:40 +1030
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040124050440.GF4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] Mapping con=pts to a port instead of con=port
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
Date: Sat, 24 Jan 2004 15:34:40 +1030
To: user-mode-linux-devel@lists.sourceforge.net

Jeff,

You just said:

> I never heard of termnetd.  I think it's less likely to be installed on
> a given system than telnetd though :-) 

True. And it isn't a replacement for the port console, but a different
approach to solving the same problem.  In researching how the port
console stuff works, I saw your original post from 31/12/2000 where you
said:

> So, what I need, and can't find, is a telnetd that's willing to attach to a 
> device rather than a port.  This would run inside UML in place of the current 
> getty.  A minicom-like proggie that doesn't do protocol won't work because the 
> two sides need to talk about terminal modes and stuff.  Does anyone know of 
> such a beast?

The same effect can be achieved with termnetd, with the advantage of
your in.telnetd solution that you aren't building in complexity that
doesn't belong to UML, but without the clomp-clomp finesse telnetd
achieves :-)

I run uml with con1=pts etc and then expose those ptys using termnetd. The
dynamic nature of /dev/ptmx results means you need to use mconsole's config
commmand to work out what port to attach to.

termnetd is part of termpkg, the poor man's terminal server. "Good for
simulations" it says on the homepage so it has to be a winner. See
http://www.linuxlots.com/~termpkg. Only thing it doesn't do is Unix98 ptys, fix
follows. It listens on INADDR_ANY, which is a bad thing I should fix too.

Look for tndCfgParse.l within termnetd within termpkg 3.3. It is is a flex (as
in the lexical analyser) definition for parsing the config file for termnetd (a
nice approach given that he's implemented lots of termios stuff there with
potential for a very complicated parser.)

--- tndCfgParse.l.orig  2004-01-24 15:09:17.000000000 +1030
+++ tndCfgParse.l       2004-01-24 15:09:53.000000000 +1030
@@ -132,7 +132,7 @@
 [Oo][Nn]      { return(YY_ON); }
 [Oo][Ff][Ff]  { return(YY_OFF); }
  
-"/dev/pts/"[0-9]{1,5} { strcpy(yylval.s, yytext); return(YY_DEVICE); }
+"/dev/"[.A-Za-z][.A-Za-z0-9_-]*|"/dev/pts/"[0-9]{1,5} { strcpy(yylval.s, yytext); return(YY_DEVICE); }
  
 [0-9A-Za-z_-]+ { strcpy(yylval.s, yytext); return(YY_IDENT); }
 .              { return(yytext[0]); }


-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
