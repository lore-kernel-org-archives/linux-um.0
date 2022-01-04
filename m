Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4rWm-00CwAX-9b
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 21:39:34 +0000
Subject: Re: Occasional hung with UM after enable VMAP_STACK
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
 <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <94613ccb-ab4d-851d-01d0-dfa72b73fdb0@kot-begemot.co.uk>
Date: Tue, 4 Jan 2022 21:39:15 +0000
MIME-Version: 1.0
In-Reply-To: <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
Content-Language: en-US
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
To: Walter Lozano <walter.lozano@collabora.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sjoerd Simons <sjoerd.simons@collabora.com>, ritesh sarraf <ritesh.sarraf@collabora.com>

On 04/01/2022 19:26, Walter Lozano wrote:
> Hi Johannes,
> 
> On 1/4/22 16:04, Johannes Berg wrote:
>> On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
>>> Hi all,
>>>
>>> I noticed that after "um: enable VMAP_STACK" [1] I experienced some
>>> occasional hung in my Gitlab CI jobs that use user-mode-linux to build
>>> distro images.
>>>
>> Did you actually *enable* VMAP_STACK in the config as well? The commit
>> just makes it *possible* to enable it, you still have to set it
>> yourself. So you should be able to easily check with/without that
>> setting.
> 
> Thank you for your quick response. The Debian configuration on package 
> user-mode-linux have these settings
> 
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> 
> 
> as you can see in [1]. I did run some tests disabling those settings, 
> which passed without any hung.
> 
> Unfortunately the "occasional" behavior makes this issue a bit tricky to 
> debug.
> 
> Regards,
> 
> Walter
> 
> [1] 
> https://salsa.debian.org/uml-team/user-mode-linux/-/blob/master/config.amd64#L321 
> 
> 

Just to narrow things down - 64 bit or 32 bit?

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

