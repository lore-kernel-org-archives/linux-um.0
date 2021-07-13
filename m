Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from m43-7.mailgun.net ([69.72.43.7])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3Ogp-00BHKi-Mw
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 20:07:40 +0000
MIME-Version: 1.0
Date: Tue, 13 Jul 2021 14:07:27 -0600
From: subashab@codeaurora.org
Subject: Re: UML kernel panic on initialization
In-Reply-To: <6442ec0e5e2cf55990b43ff178023fd6050e63fb.camel@sipsolutions.net>
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <6442ec0e5e2cf55990b43ff178023fd6050e63fb.camel@sipsolutions.net>
Message-ID: <2b6a7ddddbec7c610340e1e8c0eaf5fa@codeaurora.org>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org

On 2021-07-13 13:22, Johannes Berg wrote:
> On Sat, 2021-07-10 at 15:00 -0600, subashab@codeaurora.org wrote:
>> 
>> I have reverted the following patches (to allow for a clean revert)
>> and I don't see the panic anymore -
>> 
>> bfc58e2b98e99737409cd9f4d86a79677c5b887c
>> dc01a3b9db43abf95b801c9694980777a329e303
>> 9f0b4807a44ff81cf59421c8a86641efec586610
>> 84b2789d61156db0224724806b20110c0d34b07c
> 
> Out of those 4, the last ("separate child and...") seems actually less
> intrusive than the previous one. If you revert only the first three of
> this list, does it still happen?
> 

If only the first three reverts are applied, UML seems to hang during 
initialization-

printk: console [mc-1] enabled
EXT4-fs (ubda): mounting ext3 file system using the ext4 subsystem
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null). 
Quota mode: none.
VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
devtmpfs: mounted
This architecture does not have kernel memory protection.
Run /sbin/init as init process
INIT: version 2.88 booting
copy_context_skas0 - stub-parent reports error 3
INIT: cannot fork, retry..
copy_context_skas0 - stub-parent reports error 3
INIT: cannot fork, retry..
copy_context_skas0 - stub-parent reports error 3
INIT: cannot fork, retry..
random: fast init done
random: crng init done
copy_context_skas0 - stub-parent reports error 3
INIT: cannot fork, retry..
copy_context_skas0 - stub-parent reports error 3
INIT: cannot fork, retry..


> Does it still happen if you unset CONFIG_CC_OPTIMIZE_FOR_SIZE and do
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE instead?
> 
> johannes

If none of the reverts are applied and I set 
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE,
I still see the initialization crash.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

