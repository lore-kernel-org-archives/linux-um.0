Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n55sL-00Epd6-Qr
 for linux-um@lists.infradead.org; Wed, 05 Jan 2022 12:58:47 +0000
Message-ID: <7a228120-f8fa-53ce-8857-32330968eebb@collabora.com>
Date: Wed, 5 Jan 2022 09:58:36 -0300
MIME-Version: 1.0
Subject: Re: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
 <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
 <41fe09354fc736fb1ff2cb429e035633f24176ce.camel@sipsolutions.net>
From: Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <41fe09354fc736fb1ff2cb429e035633f24176ce.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sjoerd Simons <sjoerd.simons@collabora.com>, ritesh sarraf <ritesh.sarraf@collabora.com>

Hi Johannes,

On 1/4/22 16:49, Johannes Berg wrote:
> On Tue, 2022-01-04 at 16:26 -0300, Walter Lozano wrote:
>> Thank you for your quick response. The Debian configuration on package
>> user-mode-linux have these settings
>>
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> CONFIG_VMAP_STACK=y
> OK, so it actually _is_ enabled.
>
>> as you can see in [1]. I did run some tests disabling those settings,
>> which passed without any hung.
>>
>> Unfortunately the "occasional" behavior makes this issue a bit tricky to
>> debug.
>>
> Right.
>
> Hm. I've been running our tests with it for about three months and
> haven't observed any hangs, but I guess that doesn't mean much.

The issue is very rare at least in my setup, I had to prepare a test 
environment to stress the system in order to be able to reproduce it 
more or less consistently. I will continue investigating and share any 
useful information.

> To be honest, I have no particular reason to even want it, other than
> that it catches accidental DMA from stack more easily ... so I guess if
> we can't find anything, we might as well revert it.

I hope we will be able to find the root cause of the issue.

> Feels like it _should_ work though, since it's just a different location
> for the stack.


I see. Thank you again for your quick reply, I will keep you updated.

Regards,

Walter

-- 
Walter Lozano
Collabora Ltd.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

