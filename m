Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4pSe-00CbOv-1O
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 19:27:09 +0000
Message-ID: <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
Date: Tue, 4 Jan 2022 16:26:57 -0300
MIME-Version: 1.0
Subject: Re: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
From: Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
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

On 1/4/22 16:04, Johannes Berg wrote:
> On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
>> Hi all,
>>
>> I noticed that after "um: enable VMAP_STACK" [1] I experienced some
>> occasional hung in my Gitlab CI jobs that use user-mode-linux to build
>> distro images.
>>
> Did you actually *enable* VMAP_STACK in the config as well? The commit
> just makes it *possible* to enable it, you still have to set it
> yourself. So you should be able to easily check with/without that
> setting.

Thank you for your quick response. The Debian configuration on package 
user-mode-linux have these settings

CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y


as you can see in [1]. I did run some tests disabling those settings, 
which passed without any hung.

Unfortunately the "occasional" behavior makes this issue a bit tricky to 
debug.

Regards,

Walter

[1] 
https://salsa.debian.org/uml-team/user-mode-linux/-/blob/master/config.amd64#L321 


-- 
Walter Lozano
Collabora Ltd.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

