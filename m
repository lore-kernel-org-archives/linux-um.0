Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWUv5-0004ZL-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 23:16:59 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWUv0-0007WV-0g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 23:16:58 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
In-Reply-To: <172427175.20041122225013@surbl.org>
Message-ID: <Pine.LNX.4.58.0411230209240.3317@sparrow>
References: <41A060D2.1030802@alexb.ch> <4110531452.20041121035707@surbl.org>
	<41A09219.3030505@alexb.ch> <741244026.20041121053635@surbl.org>
	<41A0D9C5.4040502@alexb.ch> <1299383684.20041121131000@surbl.org>
	<Pine.LNX.4.58.0411211713540.3476@sparrow>
	<257112541.20041121170629@surbl.org>
	<41A18619.1040703@alexb.ch> <Pine.LNX.4.58.0411220139410.3476@sparrow>
	<41A18A93.1000006@alexb.ch> <Pine.LNX.4.58.0411220158280.3476@sparrow>
	<41A18D69.7050500@alexb.ch> <Pine.LNX.4.58.0411220216020.3476@sparrow>
	<41A19472.7050505@alexb.ch> <1091049989.20041122163343@surbl.org>
	<1798686443.20041122163843@surbl.org> <41A2D7CB.90100@alexb.ch>
	<172427175.20041122225013@surbl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: WS lag
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
Date: Tue, 23 Nov 2004 02:17:05 -0500 (EST)
To: Jeff Chan <jeffc@surbl.org>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Alex Broens <surbl@alexb.ch>, William Stearns <wstearns@pobox.com>

Good morning, all,
	(For the UML-devel mailing list: The "spamgate" virtual machine 
creates multiple text files and stores them on the host via a hostfs 
mount.  The slartibartfast and jeeves VM's publish that data read through 
a hostfs mount out via http and rsync, respectively.)

	The three vm's were publishing just fine in the 2.4.23 kernel I 
have at http://www.stearns.org/uml/ .  When I rebooted the three vm's into 
the 2.4.27 kernel I have there, slart and jeeves started showing stale 
data.  Moving spamgate back to 2.4.23 didn't help; slart and jeeves still 
presented old files to the outside world.  As soon as I moved slart and 
jeeves back to 2.4.23, the problems went away.
	Kernels and compile options used are both at 
http://www.stearns.org/uml/ .

On Mon, 22 Nov 2004, Jeff Chan wrote:

> On Monday, November 22, 2004, 10:25:15 PM, Alex Broens wrote:
> > Jeff Chan wrote:
> >   > BTW, the big file transfer was after I manually deleted
> >> sa-blacklist.current.domains on my end, but comparing a
> >> version of sa-blacklist.current.domains saved last night
> >> to the new version rsynced over, it's unchanged.
> >> 
> >> (That's bad, unless the file is truly unchanged from about 10
> >> hours ago, which seem possible, but unlikely.)
> 
> > Jeff,
> 
> > added mirrorforhappiness. com a while ago.
> 
> > Its in /processing/master-black now
> 
> > it should show up in sa-blacklist.current.domains soon.
> 
> > If I seee it in there, Id say you should as well, right?
> 
> Yes, but the copy of sa-blacklist.current.domains I'm rsyncing
> has not updated in almost 24 hours.  You can tell by checking
> the zone file serial numbers which are all in UNIX epoch seconds:
> 
>   http://www.surbl.org/nameservers-output.html
> 
> The serial for ws.surbl.org 1101111492 is almost a day
> old.  That's possible if the data itself don't update
> often, but I'm pretty sure it should be more often
> than once a day!
> 
> My script does not produce a new zone file unless
> the data has changed:
> 
>   http://spamcheck.freeapp.net/handle-sa-blacklist
> 
> Hmmm, the version I grabbed using http:
> 
>   lwp-request 'http://www.stearns.org/sa-blacklist/sa-blacklist.current.domains' > bar
> 
> does not match the version I'm getting via rsync.
> 
> But the http version matches the version I just rsynced into a
> *new* file name:
> 
>   rsync -vv -L zaphod.stearns.org::wstearns/sa-blacklist/sa-blacklist.current.domains baz
> 
> Bill can you check your server logs to see if there's anything
> unusual.
> 
> Is rsync somehow confused about timestamps?
> 
> It definitely seems to be an rsync issue.  Is there a place rsync
> stores temporary files on your server or mine that might be
> stale?

	Yes.  :-)
	Cheers,
	- Bill

---------------------------------------------------------------------------
The web page you seek
cannot be found here:
countless others await
(Courtesy of John Sage <jsage@finchhaven.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
