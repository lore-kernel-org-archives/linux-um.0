Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvoPu-0005T1-SS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 19:09:26 -0800
Received: from fed1rmmtao12.cox.net ([68.230.241.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CvoPn-0003ea-OL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 19:09:26 -0800
Message-ID: <41FEF317.3070505@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
In-Reply-To: <200501290036.51182.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 31 Jan 2005 19:10:15 -0800
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: "Christopher S. Aker" <caker@theshore.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Ok, I've uploaded the first prerelease of SKAS3 V8... It's uploaded on the 
> web-site, you can start playing for it if you want:
> 
> http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.9-v8-rc1/
> 
> if you want, impressions are welcome.... I've not yet tested it thoroughly, 
> but it should work well enough.
> 
> I'm particularly interested in seeing it tested on SMP host systems, since 
> I've added some locking and I want to be sure there is no deadlock 
> possibility.
> 
> However, *not* on production systems for now... I want to check it more 
> carefully.

I just tested this release on a vanilla single-proc AMD system.  I see 
one major problem (at least with how we run UML here).

With 2.6.7 with skas3 and earlier releases it is possible to kill a 
virtual server from the host with a standard kill command.  All of the 
sub-threads die and you can unmount/unmap the various stuff that the 
virtual used.  This is an unclean shutdown but at least lets you kill 
virtuals that have misbehaved while leaving the host up.

With 2.6.9 skas3 v8 a plain kill does nothing.  With a kill -9, 3 of the 
four thread die, but one remains and the only way to get rid of it is 
with a server reboot.

Not sure what is going on here, but I have not been able to get anything 
past 2.6.7 to work while killing virtual rudely.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
