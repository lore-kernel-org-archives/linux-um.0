Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cw7iA-0001cN-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 15:45:34 -0800
Received: from fed1rmmtao06.cox.net ([68.230.241.33])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cw7i9-00047J-9L for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 15:45:34 -0800
Message-ID: <420014D5.1030308@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
	<41FEF317.3070505@easyco.com> <41FF261A.2070001@tuxrocks.com>
	<200502010848.30042.rob@landley.net>
	<41FF9FA7.3000500@tuxrocks.com>
	<08a901c5087a$fabe3950$0201a8c0@hawk>
In-Reply-To: <08a901c5087a$fabe3950$0201a8c0@hawk>
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
Date: Tue, 01 Feb 2005 15:46:29 -0800
To: "Christopher S. Aker" <caker@theshore.net>, user-mode-linux-devel@lists.sourceforge.net

Christopher S. Aker wrote:
> With the problems we had with 2.6.9 as a host, I was wondering why Blaisorblade chose
> it when he released skas-v8-rc1.
> 
> Here is skas-v8-rc1 diffed against 2.6.10:
> 
> http://www.theshore.net/~caker/patches/skas-v8-rc1-2.6.10.patch
> 
> -Chris

Thank you for the patch.

It compiles cleanly and does run UML here, but still has the kill 
behaviour.  To recap:

   kill -TERM `pidof linux`

     does nothing

   kill -KILL `pidof linux`

     kills all but one thread, after which you can ...

   kill -CONT `pidof linux`

     which finally kills it off completely.

Having a kill -9 not work really sounds like a bug to me.  It can be 
worked around, but is "non obvious".

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
