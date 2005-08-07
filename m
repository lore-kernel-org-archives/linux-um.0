Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1t1r-0001iC-9o	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Aug 2005 14:49:59 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E1t1q-0006wi-2W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Aug 2005 14:49:59 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] NPTL pthread_create() cannot work.
References: <AD266326EC54D9118CE700110A9E2BE205EA47EA@zch07exm01.corp.mot.com>
	<200508051754.34058.blaisorblade@yahoo.it>
In-Reply-To: <200508051754.34058.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508071649.40752.rob@landley.net>
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
Date: Sun, 7 Aug 2005 16:49:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Zhu Tom-a2289c <A2289c@motorola.com>

On Friday 05 August 2005 10:54, Blaisorblade wrote:
> On Friday 05 August 2005 09:34, Zhu Tom-a2289c wrote:
> > 1.
> > I still fail to use these patches on git3/4,
>
> Hm, ok... there will be probably some trivial reject...I cannot update
> those patches right now since I haven't enough bandwidth.
>
> Just to make sure: you got errors applying until TLS patches, right?
> Anyhow, to get the TLS changes only, you need to apply only the following 4
> patches:
>
> uml-clean-arch_switch
> uml-tls-support-sc-tables
> uml-add-tls-support
> uml-add-tls-support-debug

Um, query:

If somebody wants to test out -skas0 to see if it can be made to work on an 
unmodified kbuntu "horny hedgehog" release, which version should one use?  
(The july 28 thing?  The july 31 snapshot?  Or can one just apply those four 
patches to 2.6.12 and have some reasonable expectation of something good?)

Keep in mind that -tt mode in 2.6.12.3 seems to be working for me even using 
TLS binaries/libraries.  (I have no idea why.)

Rob


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
