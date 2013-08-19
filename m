Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VBVyx-0006AX-UA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 20:23:19 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VBVyv-0000Kp-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 20:23:19 +0000
Message-ID: <52127EA7.9020309@nod.at>
Date: Mon, 19 Aug 2013 22:23:03 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1376825409-18570-1-git-send-email-richard@nod.at>
	<1376825409-18570-4-git-send-email-richard@nod.at>
	<20130819093049.GA5918@redhat.com>
In-Reply-To: <20130819093049.GA5918@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 4/4] um: Run UML in it's own session.
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am 19.08.2013 11:30, schrieb Richard W.M. Jones:
> On Sun, Aug 18, 2013 at 01:30:09PM +0200, Richard Weinberger wrote:
>> If UML is not run by a shell it can happen that UML
>> will kill unrelated proceses upon a fatal exit because
>> it issues a kill(0, ...).
>> To prevent such oddities we create a new session in main().
>>
>> Cc: rjones@redhat.com
>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> I tested this using the "debug segv" test script that I previously
> posted on the user-mode-linux mailing list, and this problem is now
> fixed.  Therefore:
> 
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Thanks for these great fixes!

Thanks for testing. :-)
I'll add all patches to uml-next.git in a few days (maybe someone finds a bug).
Expect them in v3.12.

Thanks,
//richard


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

