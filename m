Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2sCg-00033W-VP	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Aug 2005 08:09:14 -0700
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E2sCg-0001yJ-Lq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Aug 2005 08:09:14 -0700
Message-ID: <20050810080910.c4km3ejqvn8cc8k4@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
Subject: Re: [uml-devel] 'soft lockup' issue on shutdown
References: <CBELIFGMBIEPIEOFCJFAGEIPCAAA.brocka@sterlingcgi.com>
	<20050809134702.GA4254@ccure.user-mode-linux.org>
In-Reply-To: <20050809134702.GA4254@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
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
Date: Wed, 10 Aug 2005 08:09:10 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

Quoting Jeff Dike <jdike@addtoit.com>:
> On Sun, Aug 07, 2005 at 03:57:48PM -0700, Anthony Brock wrote:
>> I've been encountering a "freeze" on shutdown with guest kernel
>> 2.6.12-rc5-mm1. Today, I was busy with other things so I left it frozen for
>> a while. When I returned, I saw the following:
>>
>> Turning off swap
>> BUG: soft lockup detected on CPU#0!
>
> How reproducable is this?  I was seeing sleeps sleeping forever, often
> on shutdown, but in a different place than this.

This was very reproducible on this SuSE 9.1 Professional image. The
weird part is that it didn't affect the other 5 images that were running
the same kernel (different software install sets and uses, but same
installation media). So I'm not positive that it doesn't have something
to do specifically with this image.

I'll see if I can reproduce this behavior with a non-production copy of
the image. In the mean time, we've upgraded to a newer guest kernel
(2.6.12.4). However, I won't be able to reboot the production machine
again until the weekend. It does seems strange that this only happens on
shutdown/reboot, and then just after the message "Turning off swap".

Should I post the guest kernel .config file?

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
