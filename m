Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aizmw-0006wr-0U for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:35:42 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201]
	helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aizmv-0002ZC-6Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:35:41 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] uml-patch-2.4.23-2
Message-ID: <20040120173534.GA15399@axis.demon.co.uk>
References: <200401171547.i0HFlPtk009266@uml.user-mode-linux.org>
	<20040120092050.GA31994@axis.demon.co.uk>
	<200401201500.i0KF09DG002355@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401201500.i0KF09DG002355@ccure.user-mode-linux.org>
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
Date: Tue, 20 Jan 2004 17:35:35 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 20, 2004 at 10:00:09AM -0500, Jeff Dike wrote:
> Hmmm, I thought I did the SF upload dance, but maybe I forgot.  In any case,
> it's there now.

I have it now thanks!

I've discovered an easy way to re-create the data corruption with
ubd=mmap (with or without /dev/anon) using the fsx tool from here.

  http://www.freebsd.org/cgi/cvsweb.cgi/src/tools/regression/fsx/

Download fxs.c, compile it

  gcc -Wall -O3 -o fsx fsx.c

and run it

  ./fsx z

With ubd=mmap it blows up after less than a minute usually.  Without
it seems to run fine.

It doesn't always blow up in the same place (fsx is by default
deterministic) indicating that this is a racey sort of problem...

I diffed the hex dump to see what sort of corruptions they were.
Nothing obvious springs to mind, other than that the corruptions start
on a page boundary, but don't extend for a whole page.  Maybe the page
is being re-used before writeout has finished?

--- z.fsxgood.hex       2004-01-20 17:25:20.000000000 +0000
+++ z.hex       2004-01-20 17:25:13.000000000 +0000
@@ -7422,26 +7422,26 @@
 001cfd0: cc fa cc e1 cc 16 cc 6d cc 36 cc 6f cc de cc 32  .......m.6.o...2
 001cfe0: cc 33 cc bc cc 7f cc 14 cc 1e cc 19 cc 78 cc 2a  .3...........x.*
 001cff0: cc 55 cc 2d cc ec cc ee cc e1 cc 6e cc 12 cc 68  .U.-.......n...h
-001d000: cc 80 cc 12 cc 54 cc c8 cc 4f cc 0e cc 1e cc d1  .....T...O......
-001d010: cc 2a cc 43 cc 7d cc 1e cc 06 cc a5 cc 42 cc cb  .*.C.}.......B..
-001d020: cc 09 cc bc cc b1 cc 06 cc 65 cc 94 cc f6 cc b8  .........e......
-001d030: cc 64 cc 00 cc 41 cc 46 cc e7 cc 1f cc c1 cc 21  .d...A.F.......!
-001d040: cc c4 cc 40 cc 72 cc 26 cc 62 cc 8e cc 7c cc b5  ...@.r.&.b...|..
-001d050: cc 86 cc c0 cc c4 cc d2 cc ea cc af cc 01 cc 67  ...............g
-001d060: cc d2 cc 67 cc 79 cc 3f cc c0 cc fc cc ae cc 0f  ...g.y.?........
-001d070: cc a1 cc 2a cc 36 cc 40 cc 18 cc 05 cc 8c cc ea  ...*.6.@........
-001d080: cc 21 cc 93 cc dc cc 14 cc 82 cc 58 cc bf cc f0  .!.........X....
-001d090: cc dc cc 76 cc b9 cc 00 cc 17 cc 54 cc be cc 31  ...v.......T...1
-001d0a0: cc 2f cc 4a cc de cc 5e cc 0e cc 98 cc 49 cc 69  ./.J...^.....I.i
-001d0b0: cc 48 cc 79 cc c8 cc cc cc b8 cc 20 cc f6 cc 2b  .H.y....... ...+
-001d0c0: cc 4b cc 7f cc fb cc 22 cc 51 cc 1a cc ea cc ec  .K.....".Q......
-001d0d0: cc 01 cc 4e cc 2e cc b6 cc 2f cc 75 cc f4 cc c5  ...N...../.u....
-001d0e0: cc 26 cc cf cc 67 cc 80 cc 35 cc b0 cc ef cc fe  .&...g...5......
-001d0f0: cc 54 cc 19 cc 86 cc d4 cc e6 cc 4e cc c1 cc d5  .T.........N....
-001d100: cc 9a cc 12 cc b8 cc 1b cc b1 cc 41 cc a1 cc f3  ...........A....
-001d110: cc 08 cc f9 cc f2 cc 11 cc 60 cc a4 cc 5a cc b0  .........`...Z..
-001d120: cc e3 cc fc cc c4 cc 6f cc 0d cc 54 cc 37 cc 18  .......o...T.7..
-001d130: cc d6 cc 6c cc e2 cc de c8 62 c8 91 c8 db c8 6d  ...l.....b.....m
+001d000: c8 7c c8 0e c8 50 c8 c4 c8 4b c8 0a c8 1a c8 cd  .|...P...K......
+001d010: c8 26 c8 3f c8 79 c8 1a c8 02 c8 a1 c8 3e c8 c7  .&.?.y.......>..
+001d020: c8 05 c8 b8 c8 ad c8 02 c8 61 c8 90 c8 f2 c8 b4  .........a......
+001d030: c8 60 c8 fc c8 3d c8 42 c8 e3 c8 1b c8 bd c8 1d  .`...=.B........
+001d040: c8 c0 c8 3c c8 6e c8 22 c8 5e c8 8a c8 78 c8 b1  ...<.n.".^...x..
+001d050: c8 82 c8 bc c8 c0 c8 ce c8 e6 c8 ab c8 fd c8 63  ...............c
+001d060: c8 ce c8 63 c8 75 c8 3b c8 bc c8 f8 c8 aa c8 0b  ...c.u.;........
+001d070: c8 9d c8 26 c8 32 c8 3c c8 14 c8 01 c8 88 c8 e6  ...&.2.<........
+001d080: c8 1d c8 8f c8 d8 c8 10 c8 7e c8 54 c8 bb c8 ec  .........~.T....
+001d090: c8 d8 c8 72 c8 b5 c8 fc c8 13 c8 50 c8 ba c8 2d  ...r.......P...-
+001d0a0: c8 2b c8 46 c8 da c8 5a c8 0a c8 94 c8 45 c8 65  .+.F...Z.....E.e
+001d0b0: c8 44 c8 75 c8 c4 c8 c8 c8 b4 c8 1c c8 f2 c8 27  .D.u...........'
+001d0c0: c8 47 c8 7b c8 f7 c8 1e c8 4d c8 16 c8 e6 c8 e8  .G.{.....M......
+001d0d0: c8 fd c8 4a c8 2a c8 b2 c8 2b c8 71 c8 f0 c8 c1  ...J.*...+.q....
+001d0e0: c8 22 c8 cb c8 63 c8 7c c8 31 c8 ac c8 eb c8 fa  ."...c.|.1......
+001d0f0: c8 50 c8 15 c8 82 c8 d0 c8 e2 c8 4a c8 bd c8 d1  .P.........J....
+001d100: c8 96 c8 0e c8 b4 c8 17 c8 ad c8 3d c8 9d c8 ef  ...........=....
+001d110: c8 04 c8 f5 c8 ee c8 0d c8 5c c8 a0 c8 56 c8 ac  .........\...V..
+001d120: c8 df c8 f8 c8 c0 c8 6b c8 09 c8 50 c8 33 c8 14  .......k...P.3..
+001d130: c8 d2 c8 68 c8 de c8 da c8 62 c8 91 c8 db c8 6d  ...h.....b.....m
 001d140: c8 bd c8 78 c8 a7 c8 ca c8 e4 c8 ed c8 b8 c8 3c  ...x...........<
 001d150: c8 36 c8 f2 c8 29 c8 18 c8 ea c8 c3 c8 d8 c8 fb  .6...)..........
 001d160: c8 2c c8 27 c8 cc c8 7b c8 e3 c8 16 c8 1e c8 3f  .,.'...{.......?

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
