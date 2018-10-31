Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHnps-0007oz-11
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 10:34:53 +0000
Date: Wed, 31 Oct 2018 18:34:38 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Testing UserModeLinux with kbuild bot
Message-ID: <20181031103438.v3vayp4l42fr4fc5@wfg-t540p.sh.intel.com>
References: <1924684.J8ZAjWOtys@blindfold>
 <20181031100743.wstzibltwysrmmgr@wfg-t540p.sh.intel.com>
 <2576349.EAEpUZHT3j@blindfold>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2576349.EAEpUZHT3j@blindfold>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: Philip Li <philip.li@intel.com>, linux-um@lists.infradead.org, kbuild-all@01.org, LKP <lkp@intel.com>

On Wed, Oct 31, 2018 at 11:15:54AM +0100, Richard Weinberger wrote:
>Fengguang,
>
>Am Mittwoch, 31. Oktober 2018, 11:07:43 CET schrieb Fengguang Wu:
>> Hi Richard,
>>
>> On Wed, Oct 31, 2018 at 09:45:57AM +0100, Richard Weinberger wrote:
>> >Fengguang,
>> >
>> >I wonder what kind of tests currently are enabled for UML?
>> >If I remember correctly we disabled some a few years ago.
>>
>> Currently we are testing tree
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
>
>good! Which branches linux-next and master?

All branches will be tested by default.

>Is it also possible to test patches which land on our mailinglist?

Sure. Subscribe to this?

        linux-um@lists.infradead.org

>> There are no special settings for UML tree, so the standard build
>> tests, static checks, boot tests and runtime tests will be performed.
>> Note that there are no UML specific runtime test case.
>
>Are you interested in rumtime tests?
>Actually running a UML is pretty easy.
>I can provide some command lines.

Philip may help plan the feature. :)

Thanks,
Fengguang

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

