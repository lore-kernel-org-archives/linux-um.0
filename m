Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVXKu-0007SX-BH	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 09:11:56 -0700
Received: from viper.oldcity.dca.net ([216.158.38.4])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DVXKt-0006Xc-Ip	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 09:11:56 -0700
From: Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <4280DB48.70908@zytor.com>
References: <200505100110.16920.blaisorblade@yahoo.it>
	<200505101217.56252.blaisorblade@yahoo.it>
	<20050510034212.0d1e0799.akpm@osdl.org><4280DB48.70908@zytor.com>
Content-Type: text/plain
Message-Id: <1115741511.12402.16.camel@mindpipe>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Restoring the link to snapshots on kernel.org
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
Date: Tue, 10 May 2005 12:11:50 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, webmaster@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 2005-05-10 at 09:03 -0700, H. Peter Anvin wrote:
> Blaisorblade wrote:
> > 
> >>Nope.  They started again five days ago.
> > 
> > Would anybody restore the link from the main www.kernel.org/ page, then? I 
> > only see there (and in the finger banner) the 2.4 snapshots, not the 2.6 
> > ones.
> > 
> > I just found
> > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/, but only by knowing 
> > there were the snapshots somewhere.
> 
> It's because there is no snapshots against -rc4, simply because Linus is 
> on vacation and thus there hasn't been any changes since -rc4.
> 

How about cleaning up the v2.6/testing directory?

 [   ]  ChangeLog-2.6.9-rc4                10-Oct-2004 22:15   115k
 [   ]  LATEST-IS-2.6.11-rc5               24-Feb-2005 10:58     0k
 [   ]  LATEST-IS-2.6.12-rc1               17-Mar-2005 20:41     0k
 [   ]  LATEST-IS-2.6.12-rc2               04-Apr-2005 11:41     0k
 [   ]  LATEST-IS-2.6.12-rc3               20-Apr-2005 19:21     0k
 [   ]  LATEST-IS-2.6.12-rc4               07-May-2005 00:41     0k
 [DIR]  cset/                              04-Apr-2005 12:16      -

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
