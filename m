Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4p6o-00CZCy-9d
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 19:04:35 +0000
Message-ID: <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
Subject: Re: Occasional hung with UM after enable VMAP_STACK
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 20:04:24 +0100
In-Reply-To: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Walter Lozano <walter.lozano@collabora.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sjoerd Simons <sjoerd.simons@collabora.com>, ritesh sarraf <ritesh.sarraf@collabora.com>

On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
> Hi all,
> 
> I noticed that after "um: enable VMAP_STACK" [1] I experienced some 
> occasional hung in my Gitlab CI jobs that use user-mode-linux to build 
> distro images.
> 

Did you actually *enable* VMAP_STACK in the config as well? The commit
just makes it *possible* to enable it, you still have to set it
yourself. So you should be able to easily check with/without that
setting.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

