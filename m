Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMCK8-0005XS-IT
 for linux-um@lists.infradead.org; Thu, 02 May 2019 14:04:34 +0000
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190502105053.GA12416@kroah.com>
From: shuah <shuah@kernel.org>
Message-ID: <76e84d54-6b7e-8cc1-492b-43822fc43ac4@kernel.org>
Date: Thu, 2 May 2019 08:04:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190502105053.GA12416@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, shuah <shuah@kernel.org>, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On 5/2/19 4:50 AM, Greg KH wrote:
> On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
>> ## TLDR
>>
>> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
>> 5.2.
> 
> That might be rushing it, normally trees are already closed now for
> 5.2-rc1 if 5.1-final comes out this Sunday.
> 
>> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
>> we would merge through your tree when the time came? Am I remembering
>> correctly?
> 
> No objection from me.
> 

Yes. I can take these through kselftest tree when the time comes.
Agree with Greg that 5.2 might be rushing it. 5.3 would be a good
target.

thanks,
-- Shuah




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

