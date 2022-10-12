Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 12 Oct 2022 15:38:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221012203828.GA3117920@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221012191142.GA3109265@bhelgaas>
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
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um-owner@lists.infradead.org, linux-kernel@vger.kernel.org, helpdesk@kernel.org

On Wed, Oct 12, 2022 at 02:11:44PM -0500, Bjorn Helgaas wrote:
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

FWIW, here's a link to pipermail "archives" downloaded with:
  wget -r -np -l 1 -n d -A gz http://lists.infradead.org/pipermail/$LIST/
  tar cf $LIST.tar $LIST
  xz -9 $LIST.tar

https://drive.google.com/file/d/1zS5kricACvwhoCvmZcMSvNRHp-9PHGjd/view?usp=sharing

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

