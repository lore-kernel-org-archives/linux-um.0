Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwNXm-0004wS-KU
 for linux-um@lists.infradead.org; Mon, 04 Jan 2021 10:56:59 +0000
Subject: Re: [PATCH] um: ubd: fix command line handling of ubd
References: <20201221022434.21725-1-thehajime@gmail.com>
 <5f11-5fe1dd00-6d-1cae2c20@60061556>
 <CAFLxGvynAbtSLJweY6-oJ1egu1aSOAMPewsaz0VCrUMWazBZ4A@mail.gmail.com>
From: Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <8ea288a9-d482-3295-266b-d00cc315d2c5@collabora.com>
Date: Mon, 4 Jan 2021 10:56:53 +0000
MIME-Version: 1.0
In-Reply-To: <CAFLxGvynAbtSLJweY6-oJ1egu1aSOAMPewsaz0VCrUMWazBZ4A@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>, Hajime Tazaki <thehajime@gmail.com>

Hi Richard,

On 23/12/2020 10:19, Richard Weinberger wrote:
> On Tue, Dec 22, 2020 at 12:49 PM Christopher Obbard
> <chris.obbard@collabora.com> wrote:
>>
>> Hi Hajime,
>>
>> Doh! Thanks for sorting out this regression!
>>
>> On Monday, 21 December, 2020 02:24 GMT, Hajime Tazaki <thehajime@gmail.com> wrote:
>>> This commit fixes a regression to handle command line parameters of ubd.
>>> With a simple line "./linux ubd0="./disk-ext4.img", it fails at
>>> ubd_setup_common().  The commit adds additional checks to the variables
>>> in order to properly parse the paremeters which previously worked.
>>>
>>> Fixes: ef3ba87cb7c9 ("um: ubd: Set device serial attribute from
>>> cmdline")
>>> Cc: Christopher Obbard <chris.obbard@collabora.com>
>>> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
>>
>> Acked-by: Christopher Obbard <chris.obbard@collabora.com>
> 
> Applied, thx!
> 

Hope you don't mind the extra poke message from me, but it didn't seem 
like this patch was applied to 5.11-rc2 & I cannot see the patch under 
your tree https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/



Thanks!
Chris

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

