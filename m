Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVVYy-0000wC-RD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 09:59:41 -0700
Received: from mu-out-0910.google.com ([209.85.134.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVVYt-0003OX-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 09:59:39 -0700
Received: by mu-out-0910.google.com with SMTP id w9so305293mue
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Sep 2007 09:59:32 -0700 (PDT)
Message-ID: <46E81AC6.3000306@googlemail.com>
Date: Wed, 12 Sep 2007 18:58:46 +0200
MIME-Version: 1.0
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Len Brown <len.brown@intel.com>, "Adrian Bunk \"\"" <bunk@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Markus <lists4me@web.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

Hi all,

Here is a list of some known regressions in 2.6.23-rc6.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            10
Linus Torvalds                         6
Alan Stern                             5
Andi Kleen                             5
Hugh Dickins                           5
Trond Myklebust                        5
Andrew Morton                          4
Al Viro                                3
Alexey Starikovskiy                    3
Cornelia Huck                          3
David S. Miller                        3
Jens Axboe                             3
Stephen Hemminger                      3
Tejun Heo                              3



Unclassified

Subject         : x86_64 vdso patch is broken somehow?
References      : http://lkml.org/lkml/2007/8/29/136
Last known good : ?
Submitter       : Chuck Ebbert <cebbert@redhat.com>
Caused-By       : Andi Kleen <ak@suse.de>
                  commit 2aae950b21e4bc789d1fc6668faf67e8748300b7
Handled-By      : ?
Status          : unknown

Subject         : cpu hotplug support broken in 2.6.23-rc3/highres timers break cpu hotplug in 2.6.23-rc5
References      : http://lkml.org/lkml/2007/8/27/58
                  http://lkml.org/lkml/2007/9/3/65
Last known good : ?
Submitter       : Pavel Machek <pavel@ucw.cz>
Caused-By       : ?
Handled-By      : ?
Status          : problem is being debugged

Subject         : 2.6.23-rc3-git1 crash/stuck on VIA CN700 system
References      : http://lkml.org/lkml/2007/8/20/174
Last known good : ?
Submitter       : Stefan Becker <Stefan.Becker@nokia.com>
Caused-By       : Andi Kleen <ak@suse.de>
                  commit 19d36ccdc34f5ed444f8a6af0cbfdb6790eb1177
Handled-By      : Andi Kleen <ak@suse.de>
                  Dave Jones <davej@redhat.com>
Workaround      : http://lkml.org/lkml/2007/9/5/221
Status          : problem is being debugged

Subject         : console is messed up after resume from s2ram or switching to console from X
References      : http://lkml.org/lkml/2007/8/4/6
Last known good : ?
Submitter       : Jeff Chua <jeff.chua.linux@gmail.com>
Caused-By       : ?
Handled-By      : H. Peter Anvin <hpa@zytor.com>
                  Antonino A. Daplas <adaplas@gmail.com>
Workaround      : "s2ram --force --acpi_sleep 1 --vbe_mode"
Status          : problem is being debugged

Subject         : konqueror suddenly vanishing, "konqueror: Fatal IO error: client killed"
References      : http://lkml.org/lkml/2007/7/22/86
Last known good : ?
Submitter       : Markus <lists4me@web.de>
Caused-By       : ?
Handled-By      : Ingo Molnar <mingo@elte.hu>
Status          : problem is being debugged

Subject         : uml on x86_64 compile error
References      : http://lkml.org/lkml/2007/9/3/86
Last known good : ?
Submitter       : Adrian Bunk <bunk@kernel.org>
Caused-By       : Jeff Dike <jdike@linux.intel.com>
                  commit d1254b12c93e1e586137a2ffef71fd33cf273f35
Handled-By      : ?
Status          : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
